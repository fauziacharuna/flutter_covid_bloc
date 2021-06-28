import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_covid_bloc/covid/models/models.dart';

part 'covid_event.dart';

part 'covid_state.dart';

const _covidLimit = 20;

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final http.Client httpClient;

  CovidBloc({required this.httpClient}) : super(const CovidState());

  @override
  Stream<Transition<CovidEvent, CovidState>> transformEvents(
    Stream<CovidEvent> events,
    TransitionFunction<CovidEvent, CovidState> transitionFunction,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFunction,
    );
  }

  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async* {
    if (event is CovidFetched) {
      yield await _mapCovidFetchedToState(state);
    }
  }

  Future<CovidState> _mapCovidFetchedToState(CovidState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == CovidStatus.initial) {
        final covids = await _fetchCovids();
        return state.copyWith(
            status: CovidStatus.success, covids: covids, hasReachedMax: false);
      }
      final covids = await _fetchCovids(state.covids.length);
      return covids.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CovidStatus.success,
              covids: List.of(state.covids)..addAll(covids),
              hasReachedMax: false);
    } catch (e) {
      // throw Exception(e);
      return state.copyWith(status: CovidStatus.failure);
    }
  }

  Future<List<Covid>> _fetchCovids([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'https://covid19.mathdro.id','api/confirmed',
        <String, String>{'_start': '$startIndex', '_limit': '$_covidLimit'},
      ),

    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      print(body);
      return body.map((dynamic json) {
        // return Covid(
        //   id: json['id'] as int,
        //   confirmed: json['confirmed'] as int,
        //   deaths: json['deaths'] as int,
        //   recovered: json['recovered'] as int,
        //   country: json['countryRegion'] as String,
        // );
        return Covid(
          id: json['id'] ?? 0,
          confirmed: json['confirmed'] ?? 0,
          deaths: json['deaths'] ?? 0,
          recovered: json['recovered'] ?? 0,
          country: json['countrRegion'] ?? "",
        );
      }).toList();
    }
    throw Exception('eror fetching covids');
  }
}

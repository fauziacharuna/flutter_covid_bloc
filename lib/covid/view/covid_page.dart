import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_bloc/covid/bloc/covid_bloc.dart';
import 'package:http/http.dart' as http;
import 'view.dart';

class CovidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Covid')),
      body: BlocProvider(
        create: (_) =>
            CovidBloc(httpClient: http.Client())..add(CovidFetched()),
        child: CovidList(),
      ),
    );
  }
}

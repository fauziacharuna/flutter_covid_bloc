import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_bloc/covid/bloc/covid_bloc.dart';
import 'package:flutter_covid_bloc/covid/covid.dart';

class CovidList extends StatefulWidget {
  @override
  _CovidListState createState() => _CovidListState();
}

class _CovidListState extends State<CovidList> {
  final _scrollController = ScrollController();
  late CovidBloc _covidBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    _covidBloc = context.read<CovidBloc>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CovidBloc, CovidState>(
        builder: (context, state) {
          switch (state.status) {
            case CovidStatus.failure:
              return const Center(child: Text('failed to fetch Covid'));
            case CovidStatus.success:
              if (state.covids.isEmpty) {
                return const Center(child: Text('No Data'));
              }
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return index >= state.covids.length ? BottomLoader() : CovidListItem(covid: state.covids[index]);
                  },
                itemCount: state.hasReachedMax ? state.covids.length : state.covids.length +1 ,
                controller:  _scrollController,
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
    );
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void _onScroll(){
    if(_isBottom) _covidBloc.add(CovidFetched());
  }
  bool get _isBottom{
    if(!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
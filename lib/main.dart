import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_bloc/simple_bloc_observer.dart';
import 'package:flutter_covid_bloc/app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}
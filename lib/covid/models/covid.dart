import 'package:equatable/equatable.dart';
class Covid extends Equatable {
  const Covid({
    required this.id, required this.confirmed, required this.deaths, required this.recovered, required this.country
});

  final int id;
  final int confirmed;
  final int deaths;
  final int recovered;
  final String country;

  @override
  // TODO: implement props
  List<Object?> get props => [id, confirmed, deaths, recovered, country];
}
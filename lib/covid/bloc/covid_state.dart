part of 'covid_bloc.dart';

enum CovidStatus { initial, success, failure }

class CovidState extends Equatable {
  final CovidStatus status;
  final List<Covid> covids;
  final bool hasReachedMax;

  const CovidState(
      {this.status = CovidStatus.initial,
      this.covids = const <Covid>[],
      this.hasReachedMax = false});

  CovidState copyWith({
    CovidStatus? status,
    List<Covid>? covids,
    bool? hasReachedMax,
  }) {
    return CovidState(
      status: status ?? this.status,
      covids: covids ?? this.covids,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return '''CovidState { status: $status, hasReachedMax: $hasReachedMax, covids: ${covids.length}}''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, covids, hasReachedMax];
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:training_app/src/Models/Trainings.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  HomePageEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchHomePageRecords extends HomePageEvent {
  @override
  String toString() => 'FetchHomePageRecords';
}

class LoadHomePageEvent extends HomePageEvent {
  @override
  String toString() => 'LoadHomePageEvent';
}

class LoadFilteredRecords extends HomePageEvent {
  final List<Training> filteredTrainings;

  LoadFilteredRecords({@required this.filteredTrainings})
      : super([filteredTrainings]);

  @override
  String toString() {
    return 'LoadFilteredRecords { filteredTrainings: $filteredTrainings }';
  }
}
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:training_app/src/Models/Trainings.dart';

@immutable
abstract class HomePageState extends Equatable {
  HomePageState([List props = const <dynamic>[]]) : super(props);
}

class HomePageLoadedState extends HomePageState {

  final List<Training> allTrainings;
  final List<Training> trainingHighlights;

  HomePageLoadedState(this.allTrainings, this.trainingHighlights) : super([allTrainings, trainingHighlights]);

  @override
  String toString() => 'LoadActivitiesState { allActivities: $allTrainings, trainingHighlights: $trainingHighlights }';
}

class LoadHomePageState extends HomePageState {
  @override
  String toString() => 'HideBottomNaviBarState';
}

class HomePageFilteredRecordsState extends HomePageState {

  final List<Training> allTrainings;

  HomePageFilteredRecordsState(this.allTrainings) : super([allTrainings]);

  @override
  String toString() => 'LoadActivitiesState { allActivities: $allTrainings}';
}
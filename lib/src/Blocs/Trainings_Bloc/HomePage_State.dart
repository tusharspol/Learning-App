import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:training_app/src/Models/Trainings.dart';

@immutable
abstract class HomePageState extends Equatable {
  HomePageState([List props = const <dynamic>[]]) : super(props);
}

class HomePageLoadedState extends HomePageState {

  final List<Training> allTrainings;

  HomePageLoadedState(this.allTrainings) : super([allTrainings]);

  @override
  String toString() => 'LoadActivitiesState { allActivities: $allTrainings }';
}

class HideBottomNaviBarState extends HomePageState {
  @override
  String toString() => 'HideBottomNaviBarState';
}
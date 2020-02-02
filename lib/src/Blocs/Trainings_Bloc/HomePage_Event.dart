import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  HomePageEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchHomePageRecords extends HomePageEvent {
  @override
  String toString() => 'FetchHomePageRecords';
}

class LoadLayoutPages extends HomePageEvent {
  @override
  String toString() => 'LoadLayoutPages';
}
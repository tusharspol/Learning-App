import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_Event.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_State.dart';
import 'package:training_app/src/Models/Trainings.dart';
import 'package:training_app/src/Services/Trainings_Data.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  final TrainingsService _trainingsService;

  HomePageBloc({@required TrainingsService trainingsService})
      : _trainingsService = trainingsService ?? TrainingsService();

  @override
  HomePageState get initialState => LoadHomePageState();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if(event is FetchHomePageRecords){
      yield* _getTrainings();
    } else if(event is LoadHomePageEvent){
      yield LoadHomePageState();
    } else if(event is LoadFilteredRecords){
      yield* _getFilteredTrainings(event.filteredTrainings);
    }
  }

  Stream<HomePageState> _getTrainings() async* {
    var trainings = await _trainingsService.getTrainings();
    var highlightTrainings = await _trainingsService.getTrainingHighlights();
    yield HomePageLoadedState(trainings, highlightTrainings);
  }

  Stream<HomePageState> _getFilteredTrainings(List<Training> filteredRecords) async* {
    if(filteredRecords.length == 0){
      filteredRecords = await _trainingsService.getTrainings();
    }
    var highlightTrainings = await _trainingsService.getTrainingHighlights();
    yield HomePageLoadedState(filteredRecords, highlightTrainings);
  }

}

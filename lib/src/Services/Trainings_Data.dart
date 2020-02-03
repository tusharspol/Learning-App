import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:training_app/src/Models/Trainings.dart';

class TrainingsService {

  Future<List<Training>> getTrainings() async {
    try{
      List<Training> _trainings = new List<Training>();
      var trainings = json.decode(await rootBundle.loadString('assets/data.json'))["trainings"];          
      for(var training in trainings){
        Training t = Training.fromJson(training);
        _trainings.add(t);
      }
      return _trainings;
    }catch(e){
      return null;
    }
  }

    Future<List<Training>> getTrainingHighlights() async {
    try{
      List<Training> _trainings = new List<Training>();
      var trainings = json.decode(await rootBundle.loadString('assets/data.json'))["highlights"];          
      for(var training in trainings){
        Training t = Training.fromJson(training);
        _trainings.add(t);
      }
      return _trainings;
    }catch(e){
      return null;
    }
  }
}

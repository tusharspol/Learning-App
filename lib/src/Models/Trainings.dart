import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Training {
  final int id;
  final String name;
  final String venue;
  final DateTime startDate;
  final DateTime endDate;
  final double fees;
  final double discount;
  final String tagLine;
  final String trainingOverview;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String trainerAddress;
  final String trainerName;

  Training({
    @required this.name,
    @required this.id,
    @required this.venue,
    @required this.startDate,
    @required this.endDate,
    @required this.startTime,
    @required this.endTime,
    @required this.fees,
    @required this.discount,
    @required this.trainingOverview,
    @required this.tagLine,
    @required this.trainerAddress,
    @required this.trainerName
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'venue': venue,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'fees': fees,
        'discount': discount,
        'trainingOverview': trainingOverview,
        'tagLine': tagLine,
        'trainerAddress': trainerAddress,
        'trainerName': trainerName
  };

   Training.fromJson(Map<String, dynamic> json)
      : name = json.containsKey('name') ? json['name'] : '',
        startDate = json.containsKey('startDate') ? 
          DateTime.parse(json['startDate']) : DateTime.now(),
        endDate = json.containsKey('endDate') ? 
          DateTime.parse(json['endDate']) : DateTime.now(),
        id = json.containsKey('id') ? int.parse(json['id'].toString()) : 0,
        fees = json.containsKey('fees') ? double.parse(json['fees'].toString()) : 0,
        discount = json.containsKey('discount') ? double.parse(json['discount']) : 0,
        tagLine = json.containsKey('tagLine') ? json['tagLine'] : '',
        trainerAddress = json.containsKey('trainerAddress') ? json['trainerAddress'] : '',
        trainerName = json.containsKey('trainerName') ? json['trainerName'] : '',
        startTime = json.containsKey('startTime') ? TimeOfDay(hour:int.parse(json['startTime'].split(":")[0]),minute: int.parse(json['startTime'].split(":")[1])): TimeOfDay.now(),
        endTime = json.containsKey('endTime') ? TimeOfDay(hour:int.parse(json['endTime'].split(":")[0]),minute: int.parse(json['endTime'].split(":")[1])): TimeOfDay.now(),
        trainingOverview = json.containsKey('trainingOverview') ? json['trainingOverview'] : '',
        venue = json.containsKey('venue') ? json['venue'] : '';
}

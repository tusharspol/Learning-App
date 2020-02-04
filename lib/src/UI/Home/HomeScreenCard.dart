import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/src/Models/Trainings.dart';
import 'package:training_app/src/UI/Common/DottedBorder.dart';
import 'package:training_app/src/UI/Common/Stylings.dart';

class HomeScreenCard extends StatelessWidget {

  final Training trainingDetails;

  HomeScreenCard({Key key, @required this.trainingDetails}): super(key:key);

  getDateRange(DateTime startDate, DateTime endDate) {
    String startDateMonth = DateFormat('MMM').format(startDate).toUpperCase();
    String endDateMonth = DateFormat('MMM').format(startDate).toUpperCase();

    if(startDateMonth == endDateMonth){
      return '$startDateMonth ${startDate.day} - ${endDate.day}, ${endDate.year}';
    }
    else{
      return '$startDateMonth ${startDate.day} - $endDateMonth ${endDate.day}, ${endDate.year}';
    }
  }

  getTimeRange(TimeOfDay startTime, TimeOfDay endTime) {

    final now = new DateTime.now();
    var _tempDate = new DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    var _startDate = DateFormat('h:mm a').format(_tempDate);

    _tempDate = new DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    var _endDate = DateFormat('h:mm a').format(_tempDate);

    return '$_startDate - $_endDate';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DottedBorder(
                borderType: BorderType.Rect,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        getDateRange(trainingDetails.startDate, trainingDetails.endDate),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTimeRange(trainingDetails.startTime, trainingDetails.endTime),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        trainingDetails.venue,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trainingDetails.tagLine,
                      style: TextStyle(fontSize: 10, color: Style.primaryColor),
                    ),
                    Text(
                      trainingDetails.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Style.primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(trainingDetails.trainerName),
                            Text(trainingDetails.trainerAddress),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            color: Style.primaryColor,
                            child: Text("Enroll now", style: TextStyle(color: Colors.white),),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
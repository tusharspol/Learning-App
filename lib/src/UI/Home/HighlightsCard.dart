//shorturl.at/OS038

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/src/Models/Trainings.dart';

class HighlightsCard extends StatelessWidget {

  final Training trainingDetails;

  HighlightsCard({Key key, @required this.trainingDetails}): super(key:key);

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TrainingDetailsOverlay(trainingDetails: trainingDetails));
  }

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.multiply),
                  image: AssetImage('assets/images/Training.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  trainingDetails.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "${trainingDetails.venue}.    ${getDateRange(trainingDetails.startDate, trainingDetails.endDate)}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: '',
                          style: TextStyle(),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\$${trainingDetails.fees}',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough)),
                            TextSpan(text: '   '),
                            TextSpan(
                                text: '\$${trainingDetails.fees - trainingDetails.discount}',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ]),
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "View Details",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 14,
                          )
                        ],
                      ),
                      onPressed: () => _showOverlay(context),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class TrainingDetailsOverlay extends ModalRoute<void> {

  final Training trainingDetails;

  TrainingDetailsOverlay({@required this.trainingDetails}): super();

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  getDateRange(DateTime startDate, DateTime endDate) {
    String startDateMonth = DateFormat('MMM').format(startDate).toUpperCase();
    String endDateMonth = DateFormat('MMM').format(startDate).toUpperCase();

    if(startDateMonth == endDateMonth){
      return '$startDateMonth ${startDate.day} to ${endDate.day}, ${endDate.year}';
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

    return '$_startDate to $_endDate';
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        width: double.infinity,
        // height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Icon(Icons.close),
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trainingDetails.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("By ${trainingDetails.trainerName}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "\$${trainingDetails.fees}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent),
                    ),
                    Text(
                      "\$${trainingDetails.fees - trainingDetails.discount}",
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset("assets/images/Training.jpg"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Training Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Overview",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(trainingDetails.trainingOverview),
            SizedBox(
              height: 10,
            ),
            Text(
              "Date & Time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text("${getDateRange(trainingDetails.startDate, trainingDetails.endDate)}  -  ${getTimeRange(trainingDetails.startTime, trainingDetails.endTime)}"),
            SizedBox(
              height: 10,
            ),
            Text(
              "Venue",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(trainingDetails.venue),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              color: Colors.redAccent,
              onPressed: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                child: Text(
                  "ENROLL NOW",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

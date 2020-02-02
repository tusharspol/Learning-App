import 'package:flutter/material.dart';
import 'package:training_app/src/UI/Common/DottedBorder.dart';

class HomeScreenCard extends StatefulWidget {
  @override
  _HomeScreenCardState createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
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
                        "Oct 11 - 13, \n2019",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "8:30 am - 9:30 am",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Convention Hall, Greater Des Eoines asd asd asd asd ",
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
                      "Filling fast",
                      style: TextStyle(fontSize: 10, color: Colors.redAccent),
                    ),
                    Text(
                      "Safe Scrum Master (4.6)",
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
                          backgroundColor: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name here"),
                            Text("Address here"),
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
                            color: Colors.redAccent,
                            child: Text("Enroll now"),
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

import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {

  final BuildContext bContext;
  final StateSetter setState;
  Map<String, bool> locations;
  Map<String, bool> trainerNames;
  Map<String, bool> trainingNames;
  Function(Map<String, bool>) locationCallback;
  Function(Map<String, bool>) trainerCallback;
  Function(Map<String, bool>) trainingsCallback;
  

  FilterBottomSheet({Key key, @required this.setState, @required this.bContext, 
    @required this.locations, @required this.trainerNames, @required this.trainerCallback, @required this.trainingsCallback,
    @required this.locationCallback, @required this.trainingNames}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSortButton;



  @override
  void initState() { 
    super.initState();
    selectedSortButton = "Sort by";
  }

  Widget locationBottomSheetFilter() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.close),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
        ),
        Expanded(
          child: ListView(
        children: widget.locations.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.locations[key],
            onChanged: (bool value) {
              setState(() {
                widget.locations[key] = value;
                widget.locationCallback(widget.locations); 
              });
            },
          );
        }).toList()),
        ),
      ],
    );
  }

  Widget trainerNameBottomSheetFilter() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.close),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
        ),
        Expanded(
          child: ListView(
        children: widget.trainerNames.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.trainerNames[key],
            onChanged: (bool value) {
              setState(() {
                widget.trainerNames[key] = value;
                widget.trainerCallback(widget.trainerNames); 
              });
            },
          );
        }).toList()),
        ),
      ],
    );
  }

    Widget trainingNamesBottomSheetFilter() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.close),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
        ),
        Expanded(
          child: ListView(
        children: widget.trainingNames.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.trainingNames[key],
            onChanged: (bool value) {
              setState(() {
                widget.trainingNames[key] = value;
                widget.trainingsCallback(widget.trainingNames); 
              });
            },
          );
        }).toList()),
        ),
      ],
    );
  }

  Widget getBottomSheetFilterMenu() {
    if (selectedSortButton == "Location") {
      return Center(child: locationBottomSheetFilter());
    } 
    else if (selectedSortButton == "Training Name") {
      return trainingNamesBottomSheetFilter();
    } 
    else if (selectedSortButton == "Trainer") {
      return trainerNameBottomSheetFilter();
    }
    else {
      return Center(
        child: Text("Coming Up"),
      );
    }
  }

  Future<Null> updateFilterName(StateSetter updateState, String btnName) async {
    updateState(() {
      selectedSortButton = btnName;
    });
  }

  _filterButton(StateSetter updateState, String btnName) {
    return InkWell(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Colors.redAccent,
                    width: btnName == selectedSortButton ? 5 : 0)),
            color: btnName == selectedSortButton
                ? Colors.white
                : Colors.grey.shade300),
        child: Text(
          btnName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      onTap: () {
        updateFilterName(updateState, btnName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300))),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Sort and Filters",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            // Divider(),
            Container(
              height: 320,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _filterButton(widget.setState, "Sort by"),
                        _filterButton(widget.setState, "Location"),
                        _filterButton(widget.setState, "Training Name"),
                        _filterButton(widget.setState, "Trainer"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: getBottomSheetFilterMenu(),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

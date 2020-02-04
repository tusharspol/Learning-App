import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_Bloc.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_Event.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_State.dart';
import 'package:training_app/src/Models/Trainings.dart';
import 'package:training_app/src/Services/Trainings_Data.dart';
import 'package:training_app/src/UI/Common/BottomSheet.dart';
import 'package:training_app/src/UI/Common/Stylings.dart';
import 'package:training_app/src/UI/Home/HighlightsCard.dart';
import 'package:training_app/src/UI/Home/HomeScreenCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const kExpandedHeight = 60.0;

class _HomeScreenState extends State<HomeScreen> {
  
  HomePageBloc _homePageBloc;
  final TrainingsService _trainingsService = new TrainingsService();
  ScrollController _scrollController;
  List<Training> _highlightTrainingRecords;
  List<Training> _allTrainingRecords;
  List<Training> _filteredTrainingRecords;
  Map<String, bool> _locations;
  Map<String, bool> _trainingNames;
  Map<String, bool> _trainerNames;



  @override
  void initState() {
    super.initState();
    _homePageBloc = HomePageBloc(trainingsService: _trainingsService);
    _homePageBloc.dispatch(FetchHomePageRecords());
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _highlightTrainingRecords = new List<Training>();
    _allTrainingRecords = new List<Training>();
    _locations = {
      'Lorem': false,
      'Ipsum': false,
      'ABC': false
    };
    _trainingNames = {
      'C#': false,
      'Flutter': false,
      'Agile': false
    };
    _trainerNames = {
      'Tushar Pol': false,
      'Rahul Saxena': false,
      'Alex Madagaskar': false,
      'Rohit Sharma': false
    };
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > (kExpandedHeight * 5 + kToolbarHeight);
  }

  fetchRecordsByAllFilter() {
    List<Training> _tempTrainings = new List<Training>();
    _locations.forEach((k,v){ 
        if(v){
          try{
            var t = _allTrainingRecords.firstWhere((element) => element.venue.toLowerCase().contains(k.toLowerCase()), orElse: () => null);
            if(t != null){
              _tempTrainings.add(t);
            }
          }catch(ex){
            throw ex;
          }
        }
      });
      _trainerNames.forEach((k,v){ 
        if(v){
          try{
            var t = _allTrainingRecords.firstWhere((element) => element.trainerName.toLowerCase() == k.toLowerCase().toLowerCase(), orElse: () => null);
            if(t != null && _tempTrainings.where((a) => a.id == t.id).length == 0){
              _tempTrainings.add(t);
            }
          }catch(ex){
            throw ex;
          }
        }
      });
      _trainingNames.forEach((k,v){ 
        if(v){
          try{
            var t = _allTrainingRecords.firstWhere((element) => element.name.toLowerCase().contains(k.toLowerCase()), orElse: () => null);
            if(t != null && _tempTrainings.where((a) => a.id == t.id).length == 0){
              _tempTrainings.add(t);
            }
          }catch(ex){
            throw ex;
          }
        }
      });
      return _tempTrainings;
  }

  locationCallback(newSelectedLocations) {
    
    setState(() {
      _locations = newSelectedLocations;
      var _tempTrainings =   fetchRecordsByAllFilter();
      _homePageBloc.dispatch(LoadFilteredRecords(filteredTrainings: _tempTrainings));
    });
  }
  
  trainerNameCallback(newSelectedTrainerNames) {
    setState(() {
      _trainerNames = newSelectedTrainerNames;
      var _tempTrainings =   fetchRecordsByAllFilter();
      _homePageBloc.dispatch(LoadFilteredRecords(filteredTrainings: _tempTrainings));
    });
  }
  
  trainingCallback(newTrainingNames) {
    setState(() {
      _trainingNames = newTrainingNames;
      var _tempTrainings =   fetchRecordsByAllFilter();
      _homePageBloc.dispatch(LoadFilteredRecords(filteredTrainings: _tempTrainings));
    });
  }


  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return FilterBottomSheet(
              bContext: context,
              setState: setState,
              locations: _locations,
              trainerNames: _trainerNames,
              trainingNames: _trainingNames,
              locationCallback: locationCallback,
              trainingsCallback: trainingCallback,
              trainerCallback: trainerNameCallback, 
            );
          });
        });
  }

  List<Widget> _getHomeScreenCards() {
    List<Widget> homeScreenCards = new List<Widget>();
    homeScreenCards.add(SizedBox(
      height: 15,
    ));
    for (var training in _filteredTrainingRecords) {
      homeScreenCards.add(HomeScreenCard(
        trainingDetails: training,
      ));
    }
    return homeScreenCards;
  }

  Widget _appBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Style.primaryColor,
      expandedHeight: 350,
      title: Text("Trainings", style: TextStyle(fontSize: 26),),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            MyCustomContainer(
              backgroundColor: Style.primaryColor,
              progress: 0.6,
              size: 150,
              progressColor: Colors.white,
            ),
            Positioned(
              top: 100,
              left: 15,
              child: SizedBox(
                child: Text(
                  "Highlights",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 0,
              child: Opacity(
                opacity: 1,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    height: 200.0,
                    viewportFraction: 0.95,
                    reverse: false,
                    enableInfiniteScroll: false,
                    items: _highlightTrainingRecords.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return HighlightsCard(
                            trainingDetails: i,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _filterSliverBar() {
    return SliverAppBar(
        backgroundColor: Colors.white,
        pinned: true,
        expandedHeight: kExpandedHeight,
        title: _showTitle
            ? SizedBox(
                width: 90,
                height: 30,
                child: OutlineButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.filter_list,
                        size: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  onPressed: () {
                    _modalBottomSheetMenu();
                  },
                ),
              )
            : null,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.none,
          background: Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.shade300, blurRadius: 10.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                    ),
                    SizedBox(
                      width: 90,
                      height: 30,
                      child: OutlineButton(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.filter_list,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Filter", style: TextStyle(fontSize: 12))
                          ],
                        ),
                        onPressed: () {
                          _modalBottomSheetMenu();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder(
        bloc: _homePageBloc,
        builder: (BuildContext context, HomePageState state) {
          if (state is LoadHomePageState) {
            return Material(
              child: Center(
                child: CircularProgressIndicator(
                    backgroundColor: Style.primaryColor),
              ),
            );
          }

          if (state is HomePageLoadedState) {
            _filteredTrainingRecords = state.allTrainings;
            _highlightTrainingRecords = state.trainingHighlights;
            _allTrainingRecords = state.allTrainings;
            if (state.allTrainings != null) {
              return Material(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    _appBar(),
                    _filterSliverBar(),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        _getHomeScreenCards(),
                      ),
                    )
                  ],
                ),
              );
            }
            else {
              return Material(
                child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Style.primaryColor),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class MyCustomContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;
  final double progress;
  final double size;

  const MyCustomContainer({
    Key key,
    this.backgroundColor = Colors.redAccent,
    this.progressColor = Colors.black,
    @required this.progress,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Container(
              color: backgroundColor,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size * progress,
                color: progressColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

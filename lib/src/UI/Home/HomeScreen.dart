import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_Bloc.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_Event.dart';
import 'package:training_app/src/Blocs/Trainings_Bloc/HomePage_State.dart';
import 'package:training_app/src/Models/Trainings.dart';
import 'package:training_app/src/Services/Trainings_Data.dart';
import 'package:training_app/src/UI/Home/HomeScreenCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSortButton = "";
  double modalHeight = 260;
  HomePageBloc _homePageBloc;
  final TrainingsService _trainingsService = new TrainingsService();

  @override
  void initState() {
    super.initState();
    selectedSortButton = "Sort by";
    _homePageBloc = HomePageBloc(trainingsService: _trainingsService);
    _homePageBloc.dispatch(FetchHomePageRecords());
  }

  circleButton() {
    return Container(
      padding: EdgeInsets.all(10),
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade300, blurRadius: 10.0)
        ],
      ),
      child: Icon(
        Icons.flight,
        color: Color(0xff007AFD),
      ),
    );
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

  Future<Null> updateFilterName(StateSetter updateState, String btnName) async {
    updateState(() {
      selectedSortButton = btnName;
    });
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 500,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300))),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sort and Filters",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
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
                    Expanded(
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
                                _filterButton(setState, "Sort by"),
                                _filterButton(setState, "Location"),
                                _filterButton(setState, "Training Name"),
                                _filterButton(setState, "Trainer"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                children: <Widget>[
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "Search",
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.search),
                                        suffixIcon: Icon(Icons.close),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          });
        });
  }

  List<Widget> _getHomeScreenCards(List<Training> _trainings) {
    List<Widget> homeScreenCards = new List<Widget>();
    homeScreenCards.add(SizedBox(
      height: 15,
    ));
    for (var training in _trainings) {
      homeScreenCards.add(HomeScreenCard());
    }
    return homeScreenCards;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder(
        bloc: _homePageBloc,
        builder: (BuildContext context, HomePageState state) {
          if (state is HomePageLoadedState) {
            var a = state.allTrainings;
            return Material(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(expandedHeight: 230),
                    pinned: true,
                  ),
                  SliverAppBar(
                      pinned: true,
                      expandedHeight: 150.0,
                      actions: <Widget>[
                        OutlineButton(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.filter_list),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Filter")
                            ],
                          ),
                          onPressed: () {
                            _modalBottomSheetMenu();
                          },
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        
                        background: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 10.0)
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 90,
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  OutlineButton(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.filter_list),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Filter")
                                      ],
                                    ),
                                    onPressed: () {
                                      _modalBottomSheetMenu();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 10.0)
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 90,
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                ),
                                OutlineButton(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.filter_list),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Filter")
                                    ],
                                  ),
                                  onPressed: () {
                                    _modalBottomSheetMenu();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      _getHomeScreenCards(state.allTrainings),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          color: Colors.redAccent,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "Trainings",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),

        // Center(
        //   child: Opacity(
        //     opacity: shrinkOffset / expandedHeight,
        //     child: Text(
        //       "MySliverAppBar",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w700,
        //         fontSize: 23,
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: 15,
          child: Opacity(
              opacity: (1 - shrinkOffset / (expandedHeight)),
              child: SizedBox(
                child: Text(
                  "Highlights",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
        ),

        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SizedBox(
              height: expandedHeight,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                height: 150.0,
                viewportFraction: 0.95,
                reverse: false,
                enableInfiniteScroll: false,
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 150,
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double _width = 0;

//   Widget topBar() {
//     return Stack(
//           children: <Widget>[
//             Positioned(
//               top: 0,
//               child: Container(
//                 width: _width,
//                 height: 200,
//                 color: Colors.redAccent,
//               ),
//             ),
//             Positioned(
//               top: 200,
//               child: Container(
//                 width: _width,
//                 height: 150,
//                 color: Colors.blueAccent,
//               ),
//             ),
//             Positioned(
//               top: 150,
//               right: 0,
//               // bottom: 0,
//               left: 0,
//               child: SizedBox(

//                 child: CarouselSlider(
//                   height: 100.0,
//                   items: [1, 2, 3, 4, 5].map((i) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration: BoxDecoration(color: Colors.amber),
//                             child: Text(
//                               'text $i',
//                               style: TextStyle(fontSize: 16.0),
//                             ));
//                       },
//                     );
//                   }).toList(),
//                 ),
//               ),
//             )
//           ],
//         );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         body: topBar(),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Widget testHome() {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             pinned: true,
//             expandedHeight: 500.0,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 alignment: Alignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 fit: StackFit.loose,
//                 children: <Widget>[
//                   Positioned(
//                       left: 0.0,
//                       top: 0.0,
//                       child: Container(
//                         width: double.infinity,
//                         height: 80.0,
//                         decoration: BoxDecoration(color: Colors.red),
//                       )),
//                   Positioned(
//                       left: 30.0,
//                       top: 30.0,
//                       child: Container(
//                         width: 100.0,
//                         height: 80.0,
//                         decoration: BoxDecoration(color: Colors.red),
//                         child: Image.network(
//                           'https://picsum.photos/250?image=9',
//                           fit: BoxFit.cover,
//                         ),
//                       )),

//                   // Positioned(
//                   //     left: 0.0,
//                   //     top: 0.0,
//                   //     child: Container(
//                   //       width: 100.0,
//                   //       height: 80.0,
//                   //       decoration: BoxDecoration(color: Colors.red),
//                   //       child: Text('hello'),
//                   //     )),
//                   // Container(
//                   //     margin: EdgeInsets.only(top: 16.0),
//                   //     padding: EdgeInsets.only(left: 32.0, right: 32.0),
//                   //     child: Image.network(
//                   //       'https://picsum.photos/250?image=9',
//                   //       fit: BoxFit.cover,
//                   //     )),
//                   // Container(
//                   //   width: double.infinity,
//                   //   height: 120,
//                   //   color: Colors.purple,
//                   // ),
//                 ],
//               ),
//             ),
//             // flexibleSpace: FlexibleSpaceBar(
//             //   // title: Text('_SliverAppBar'),
//             //   // background: Stack(
//             //   //   children: <Widget>[
//             //   //     Positioned(
//             //   //       left: 20,

//             //   //     )
//             //   //   ],
//             //   // ),

//             // ),
//             title: Text("data"),
//           ),
//           SliverGrid(
//             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200.0,
//               mainAxisSpacing: 10.0,
//               crossAxisSpacing: 10.0,
//               childAspectRatio: 4.0,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Container(
//                   alignment: Alignment.center,
//                   color: Colors.teal[100 * (index % 9)],
//                   child: Text('Grid Item $index'),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//           SliverFixedExtentList(
//             itemExtent: 50.0,
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Container(
//                   alignment: Alignment.center,
//                   color: Colors.lightBlue[100 * (index % 9)],
//                   child: Text('List Item $index'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => {},
//         tooltip: '+',
//         child: Icon(Icons.accessibility_new),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: testHome());
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 230),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 80,
                )
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  title: Text("Index: $index"),
                ),
              ),
            )
          ],
        ),
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
              child: Text("Highlights", style: TextStyle(fontSize: 18, color: Colors.white),),
            )
          ),
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

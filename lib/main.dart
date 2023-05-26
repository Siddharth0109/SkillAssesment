import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Skill Assessment Home'),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        child: Page(),
        // child: MainContent(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  double left = 0;
  double top = 0;
  late double startHori;
  late double startVert;
  double containerWidth = 100;
  double containerHeight = 100;

  late double greenTop;
  late double greenLeft;

  late double redTop;
  late double redLeft;

  late var topVal;
  late var leftVal;

  late var globalPositionDetail;

  @override
  Widget build(BuildContext context) {
    greenTop = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height / 2;
    greenLeft = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 3;

    redTop = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height / 1.2;
    redLeft = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 1.2;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                GridView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.red
                            : index == 1
                                ? Colors.grey
                                : index == 2
                                    ? Colors.grey
                                    : Colors.green,
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(28),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                ),
                Positioned(
                    top: top,
                    left: left,
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState(() {
                          startHori = details.globalPosition.dx;
                          startVert = details.globalPosition
                              .dy; // top = 207.64285714285714  // 415.2857142857143 // 205.71428571428572 // 800.8571428571429
                        });
                      },

                      // green top(bottom) => MediaQuery.of(context).size.height / 2.2.toDouble();
                      // green top (top) => MediaQuery.of(context).size.height / 4.toDouble();

                      // green left (left) => MediaQuery.of(context).size.height / 2.toDouble();
                      // green left (right) => MediaQuery.of(context).size.height / 1.1.toDouble();

                      onPanDown: (details) {},
                      onPanEnd: (details) {
                        setState(() {
                          /*  top =
                              MediaQuery.of(context).size.height / 4.toDouble();
                          left = MediaQuery.of(context).size.width /
                              1.1.toDouble();*/

// top-bottom = 2.5 = 332.2285714285714
// top-top = 4.5 = 184.57142857142856

// left-left = 4.5 = 184.57142857142856
// left-right = 2.5 = 184.57142857142856



                         /* print("top-top => ${MediaQuery.of(context).size.height /
                              4.5.toDouble()}");
                          print("top-bottom => ${MediaQuery.of(context).size.height /
                              2.5.toDouble()}");
                          print("left-left => ${MediaQuery.of(context).size.height /
                              3.toDouble()}");
                          print("left-right => ${MediaQuery.of(context).size.height /
                              1.1.toDouble()}");*/
                          print("topVal => ${topVal}");
                          print("leftVal => ${leftVal}");
                          print("top => ${top}");
                          print("left => ${left}");


                          top = MediaQuery.of(context).size.height /
                              4.5.toDouble();

                          left = MediaQuery.of(context).size.width /
                              2.5.toDouble();

                          print("top => ${top}");
                          print("left => ${left}");

                       /*   if ((topVal >
                                      MediaQuery.of(context).size.height /
                                          4.toDouble() &&
                                  topVal <
                                      MediaQuery.of(context).size.height /
                                          2.2.toDouble()) &&
                              leftVal >
                                  MediaQuery.of(context).size.height /
                                      3.toDouble() &&
                              topVal <
                                  MediaQuery.of(context).size.height /
                                      1.1.toDouble()) {
                            top = greenTop;
                            left = greenLeft;
                          }else{
                            top = redTop;
                            left = redLeft;
                          }*/

                          /* if (topVal != greenTop) {
                            top = greenTop;
                          }

                          if (leftVal != greenLeft) {
                            left = greenLeft;
                          }*/
                        });
                      },
                      onPanUpdate: (details) {
                        var screenWidth = MediaQuery.of(context).size.width;
                        var screenHeight = MediaQuery.of(context).size.height;

                        globalPositionDetail = details.globalPosition;

                        topVal = details.globalPosition.dy - startVert;
                        leftVal = details.globalPosition.dx - startHori;

                        var leftBounds = screenWidth - containerWidth;
                        var topBounds = screenHeight - containerHeight;

                        setState(() {
                          if (leftVal.floor() >= 0 && leftVal <= leftBounds) {
                            left = leftVal.floorToDouble();
                          }

                          if (leftVal < 0) {
                            left = 0;
                          }

                          if (leftVal > leftBounds) {
                            left = leftBounds.floorToDouble();
                          }

                          if (topVal.floor() >= 0 && topVal <= topBounds) {
                            top = topVal.floorToDouble();
                          }

                          if (topVal < 0) {
                            top = 0;
                          }

                          if (topVal > topBounds) {
                            top = topBounds.floorToDouble();
                          }
                        });
                      },
                      child: const Icon(Icons.star,
                          color: Colors.yellow, size: 50),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

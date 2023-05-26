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
  late double greenBottom;
  late double greenLeft;
  late double greenRight;

  late double redTop;
  late double redBottom;
  late double redLeft;
  late double redRight;

  late var redStarTop;
  late var redStarLeft;

  late var greenStarTop;
  late var greenStarLeft;

  late var topVal;
  late var leftVal;

  bool isStarInRed = true;
  bool isStarInGreen = false;


  @override
  Widget build(BuildContext context) {
    redStarTop = MediaQuery.of(context).size.height / 8.toDouble();
    redStarLeft = MediaQuery.of(context).size.width / 5.toDouble();

    greenStarTop = MediaQuery.of(context).size.height / 3.5.toDouble();
    greenStarLeft = MediaQuery.of(context).size.width / 1.5.toDouble();

    greenTop = MediaQuery.of(context).size.height / 4.5.toDouble();
    greenBottom = MediaQuery.of(context).size.height / 2.5.toDouble();
    greenLeft = MediaQuery.of(context).size.width / 2.5;
    greenRight = MediaQuery.of(context).size.width / 1.2;

    redTop = MediaQuery.of(context).size.height / 100.toDouble();
    redBottom = MediaQuery.of(context).size.height / 4.5.toDouble();
    redLeft = MediaQuery.of(context).size.width / 20.toDouble();
    redRight = MediaQuery.of(context).size.width / 2.2.toDouble();


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
                          startVert = details.globalPosition.dy;
                        });
                      },
                      onPanDown: (details) {},
                      onPanEnd: (details) {
                        setState(() {
                          if ((topVal >= greenTop && topVal <= greenBottom) &&
                              (leftVal >= greenLeft && leftVal <= greenRight)) {
                            top = greenStarTop;
                            left = greenStarLeft;
                            isStarInRed = false;
                            isStarInGreen = true;
                          } else if ((topVal >= redTop &&
                                  topVal <= redBottom) &&
                              (leftVal >= redLeft && leftVal <= redRight)) {
                            top = redStarTop;
                            left = redStarLeft;
                            isStarInRed = true;
                            isStarInGreen = false;
                          } else if (isStarInRed) {
                            top = redStarTop;
                            left = redStarLeft;
                            isStarInRed = true;
                            isStarInGreen = false;
                          } else {
                            top = greenStarTop;
                            left = greenStarLeft;
                            isStarInRed = false;
                            isStarInGreen = true;
                          }
                        });
                      },
                      onPanUpdate: (details) {
                        var screenWidth = MediaQuery.of(context).size.width;
                        var screenHeight = MediaQuery.of(context).size.height;

                        topVal = details.globalPosition.dy - startVert;
                        leftVal = details.globalPosition.dx - startHori;

                        var leftBounds = screenWidth - containerWidth;
                        var topBounds = screenHeight - containerHeight;

                        setState(() {
                          if (leftVal.floor() >= 0 && leftVal <= leftBounds) {
                            left = leftVal.floorToDouble();
                          }

                          if (leftVal > leftBounds) {
                            left = leftBounds.floorToDouble();
                          }

                          if (topVal.floor() >= 0 && topVal <= topBounds) {
                            top = topVal.floorToDouble();
                          }


                          if (topVal > topBounds) {
                            top = topBounds.floorToDouble();
                          }
                        });
                      },
                      child: const Icon(Icons.star,
                          color: Colors.yellow, size: 100),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

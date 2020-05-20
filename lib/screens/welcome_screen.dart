import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import '../screens/auth_screen.dart.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation =
        ColorTween(begin: Colors.white, end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: animation.value,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xff05463F),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                  CircleAvatar(
                    backgroundColor: Color(0xff05463F),
                    radius: 100,
                      child: Image.asset('assets/images/optima_logo_1.png'),                      
                  ),
                  Text('OPTIMA',
                  style: TextStyle(color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w600
                  ),
                  ),
                  SizedBox(
                    width: 250.0,
                    child: FadeAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Optimize your shopping experience",
                          "Hack the COVID Crisis",
                        ],
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "lineto",
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional
                            .centerStart // or Alignment.topLeft
                        ),
                  ),
                  Center(
                    child: Text(
                      "Click anywhere to proceed",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w800),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Hero(
                  //       tag: 'ibm',
                  //       child: Center(
                  //         child: Container(
                  //           child: Image.asset('assets/images/ibm.png'),
                  //           height: 25.0,
                  //         ),
                  //       ),
                  //     ),
                  //     Hero(
                  //       tag: 'nasscom',
                  //       child: Center(
                  //         child: Container(
                  //           child: Image.asset('assets/images/nasscom.png'),
                  //           height: 25.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AuthScreen()));
      },
    );
  }
}

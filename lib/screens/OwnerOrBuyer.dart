import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'constants.dart';
class OwnerOrBuyer extends StatefulWidget {
  @override
  _OwnerOrBuyerState createState() => _OwnerOrBuyerState();
}

class _OwnerOrBuyerState extends State<OwnerOrBuyer> {




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Container(
                color: Colors.red,
                margin: new EdgeInsets.only(

                  bottom: 2.0,

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 40.0,
                          color: Colors.white,

                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 25.0,
                          color: Colors.white,

                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'as',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Owner/Buyer',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 45.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ),






            SizedBox(
              height: 80.0,
            ),


            Center(
              child: GredientButton(onPressed: (){
                seller=true;
                Navigator.pushNamed(context, "LoginAndRegPage");
              },

                radius: 15.0,
                splashColor: Colors.redAccent,
                colors: [
                  Colors.orange ,
                  Colors.red,
                ],
                title: "Seller",
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: GredientButton(onPressed: (){

                Navigator.pushNamed(context, "LoginAndRegPage");
              },
                radius: 15.0,
                splashColor: Colors.red,
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
                title: "Buyer",

              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 110.0,
              ),
            ),
            Center(
              child: Text(
                'Shopping made easy',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



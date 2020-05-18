import 'package:flutter/material.dart';
import '../widgets/auth_card.dart';


enum AuthMode { Signup, Login }


class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 100
                ),
              child: Text('Hey there!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold
                  ) 
                  ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(189, 22, 0, 1).withOpacity(0.9),
                  Color.fromRGBO(255, 45, 0, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.all(5),
                        height: 170,
                        child: Image.asset('assets/images/optima_logo.png')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

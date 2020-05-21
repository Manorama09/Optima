import 'package:flutter/material.dart';
import '../widgets/auth_card.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 400,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 120
                ),
            child: Image.asset('assets/images/optima_logo_1.png')),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff075E54),
                  Color(0xff05463F),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height:155
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
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

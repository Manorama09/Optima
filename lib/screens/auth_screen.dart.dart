import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import '../providers/users.dart';
import '../providers/user.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'products_overview_screen.dart';
import 'package:optima/providers/auth.dart';


class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
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
        ColorTween(begin: Colors.white, end: Colors.white).animate(
            controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Center(
              child: Hero(
                tag: 'new_optima',
                child: Center(
                  child: Container(
                    child: Image.asset('assets/images/optima_logo.png'),
                    height: 120.0,
                  ),
                ),
              ),
            ),


            SizedBox(
              width: 250.0,
              child: FadeAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Optimize the experience",
                    "Hack the COVID Crisis",


                  ],
                  textStyle: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.centerStart // or Alignment.topLeft
              ),
            ),



            SizedBox(
              height: 48.0,
            ),
            Center(
              child: GredientButton(onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new AuthScreen()));
              },
                radius: 15.0,
                splashColor: Colors.deepOrangeAccent,
                colors: [
                  Colors.orange,
                  Colors.deepOrange,
                ],
                title: "Click here to proceed",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Hero(
                  tag: 'ibm',
                  child: Center(
                    child: Container(
                      child: Image.asset('assets/images/ibm.png'),
                      height: 25.0,
                    ),
                  ),
                ),



                Hero(
                  tag: 'nasscom',
                  child: Center(
                    child: Container(
                      child: Image.asset('assets/images/nasscom.png'),
                      height: 25.0,
                    ),
                  ),

                ),
              ],
            ),

          ],
        ),


      ),

    );
  }
}














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

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'user':''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  String result;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          authData['email'],
          authData['password'],
          authData['user']
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          authData['email'],
          authData['password'],
          authData['user']
        );

        try {
        final newUser = new User(
        email: authData['email'],
        userType: authData['user']
       // id: json.decode(response.body)['name'],
      );
        await Provider.of<Users>(context, listen: false).addUser(newUser);
      }
      catch (error)
      {
//        await showDialog(
//          context: context,
//          builder: (ctx) => AlertDialog(
//                title: Text('An error occurred!'),
//                content: Text('Something went wrong.'),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text('Okay'),
//                    onPressed: () {
//                      Navigator.of(ctx).pop();
//                    },
//                  )
//                ],
//              ),

      }
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
      new ProductsOverviewScreen(authData['user']))
      );
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  int radioValue=0;

  void handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 0:
        result= 'customer';
          break;
        case 1:
        result= 'seller';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 400 : 330,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },

                  onSaved: (value) {
                    authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                  SizedBox(
                    height: 15,
                   ),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         new Radio(
                           value: 0,
                           groupValue: radioValue,
                           onChanged: (newValue) {
                            handleRadioValueChange(0);
                             setState(() {
                               print(result);
                               authData['user'] = result;
                             });
                           },
                         ),
                         new Text('Customer'),
                         new Radio(
                           value: 1,
                           groupValue: radioValue,
                          onChanged: (newValue) {
                            handleRadioValueChange(1);
                             setState(() {
                               authData['user'] = result;
                             });
                           },
                         ),
                         new Text('Seller'),
                       ],
                     ),
//                  TextFormField(
//                  decoration: InputDecoration(labelText: 'customer/seller'),
//                  onSaved: (value) {
//                    authData['user'] = value;
//                  },
//                  ),

                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),

                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

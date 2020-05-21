import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:optima/providers/auth.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';
import '../screens/products_overview_screen.dart';
import '../screens/auth_screen.dart';


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

  Map<String, dynamic> authData = {
    'email': '',
    'password': '',
    'seller': false
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

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
          authData['seller']
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          authData['email'],
          authData['password'],
          authData['seller']
        );

      //   try {
      //   final newUser = new User(
      //   email: authData['email'],
      //   userType: authData['user']
      //  // id: json.decode(response.body)['name'],
      // );
      //   await Provider.of<Users>(context, listen: false).addUser(newUser);
      // }
      // catch (error)
      // {
      //  await showDialog(
      //    context: context,
      //    builder: (ctx) => AlertDialog(
      //          title: Text('An error occurred!'),
      //          content: Text('Something went wrong.'),
      //          actions: <Widget>[
      //            FlatButton(
      //              child: Text('Okay'),
      //              onPressed: () {
      //                Navigator.of(ctx).pop();
      //              },
      //            )
      //          ],
      //        )
      //  );

      // }
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
      Navigator.of(context).pushNamed('/');

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
  bool seller;
  int radioValue=0;
  void handleRadioValueChange(int value) {    
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 0:
        seller= false;
          break;
        case 1:
        seller= true;
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
        height: _authMode == AuthMode.Signup ? 380 : 320,
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
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         new Radio(
                           activeColor: Color(0XFFEC4C4D),
                           value: 0,
                           groupValue: radioValue,
                           onChanged: (newValue) { 
                             handleRadioValueChange(0);
                             setState(() {
                               authData['seller'] = seller;
                             });
                           },
                         ),
                         new Text('Customer'),
                         new Radio(
                           activeColor: Color(0XFFEC4C4D),
                           value: 1,
                          groupValue: radioValue,
                          onChanged: (newValue) {
                            handleRadioValueChange(1);
                             setState(() {
                               authData['seller'] = seller;
                             });
                           },
                         ),
                         new Text('Seller'),
                       ],
                     ),
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

import 'package:flutter/material.dart';
import '../providers/item.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class ItemRequestScreen extends StatefulWidget {
  static const routeName = '/request-product';
  @override
  _ItemRequestScreen createState() => _ItemRequestScreen();
}

class _ItemRequestScreen extends State<ItemRequestScreen> {
  final _form = GlobalKey<FormState>();
  String value = "";
  var _isLoading = false;

  Future<void> _saveForm() async {
    final authData = Provider.of<Auth>(context, listen: false);
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Item>(context, listen: false)
          .addItem(authData.token, value);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
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
    setState(() {
      _isLoading = false;
    });
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Thank you!'),
              content: Text('Your request was noted.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Item'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Let us know what you need!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25
                      ),),
                    ),
                    SizedBox(
                      height:50
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          value = text;
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: 'Enter item',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          suffixIcon: IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: Icon(Icons.send),
                              onPressed: _saveForm),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

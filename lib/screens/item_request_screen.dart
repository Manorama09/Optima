import 'package:flutter/material.dart';
import '../providers/item.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'visual_recognition_screen.dart';
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
          title: Text('An error occurred!',
           style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),),
          content: Text('Something went wrong.',
          style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),
              ),
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
              title: Text('Thank you!',
               style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),),
              content: Text('Your request was noted.',
               style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay',
                   style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontWeight: FontWeight.w600
              ),),
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                     SizedBox(
                height:MediaQuery.of(context).size.height/15,
              ),
              Text('Request for a',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 40,
                fontWeight: FontWeight.w600
              ),),
              Text('Product',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 65,
                fontWeight: FontWeight.w600
              ),),
              Divider(color: Colors.grey,),
              SizedBox(
                height:MediaQuery.of(context).size.height/40,
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Let us know what you need!',
                      textAlign: TextAlign.left,
                      
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "lineto",
                fontSize: 25,
                fontWeight: FontWeight.w400
              ),),
                    ),
                    SizedBox(
                height:MediaQuery.of(context).size.height/100,
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
                          hintText: 'Enter product title',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
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
                    
                    SizedBox(
                        height:MediaQuery.of(context).size.height/15
                    ),
                    Text('  You can also upload a photo instead!',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "lineto",
                fontSize: 17,
                fontWeight: FontWeight.w400
              ),),
              SizedBox(
                        height:MediaQuery.of(context).size.height/100
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ScreenVisualRecognition()));
                        },
                        child: Text('Upload a Photo',
                        style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

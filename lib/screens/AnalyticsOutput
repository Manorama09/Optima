import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optima/providers/fire_storage_service.dart';
//void main() => runApp(MyApp());



final Color yellow = Colors.red;
final Color orange = Colors.red;
final String image1 = "ibm.png";
final String image2 = "tree.jpg";

String image = image1;

class LoadFirebaseStorageImage extends StatefulWidget {
  @override
  _LoadFirebaseStorageImageState createState() =>
      _LoadFirebaseStorageImageState();
}

class _LoadFirebaseStorageImageState extends State<LoadFirebaseStorageImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [orange, yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Loading image from Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: FutureBuilder(
                            future: _getImage(context, image),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                return Container(
                                  height:
                                  MediaQuery.of(context).size.height / 1.25,
                                  width:
                                  MediaQuery.of(context).size.width / 1.25,
                                  child: snapshot.data,
                                );

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.25,
                                    width: MediaQuery.of(context).size.width /
                                        1.25,
                                    child: CircularProgressIndicator());

                              return Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loadButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () {
                //fetch another image
                setState(() {
                  final _random = new Random();
                  var imageList = [image1, image2];
                  image = imageList[_random.nextInt(imageList.length)];
                });
              },
              child: Text(
                "Load Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }
}

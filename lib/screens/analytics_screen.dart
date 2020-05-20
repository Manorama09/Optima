import 'dart:math';
import 'package:flutter/material.dart';
import 'package:optima/providers/fire_storage_service.dart';
import 'package:optima/widgets/app_drawer.dart';


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
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('  View',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 90,
                fontWeight: FontWeight.w700
              ),),
               Text('   Analytics',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 60,
                fontWeight: FontWeight.w700
              ),),
              Divider(color: Colors.grey,),
              
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
                                return Center(
                                  child: Container(
                                    height:
                                    MediaQuery.of(context).size.height / 1.25,
                                    width:
                                    MediaQuery.of(context).size.width / 1.25,
                                    child: snapshot.data,
                                  ),
                                );

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return                                
                                     Center(child: CircularProgressIndicator());

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
               margin: EdgeInsets.all(25),
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                  final _random = new Random();
                  var imageList = [image1, image2];
                  image = imageList[_random.nextInt(imageList.length)];
                });
                },
                        child: Text('Load Photo',
                        style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              ),
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

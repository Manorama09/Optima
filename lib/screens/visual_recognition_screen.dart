import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_ibm_watson/flutter_ibm_watson.dart';
import 'package:flutter_ibm_watson/visual-recognition/VisualRecognition.dart';
import 'package:flutter_ibm_watson/utils/Language.dart';
import 'package:flutter_ibm_watson/utils/IamOptions.dart';

class ScreenVisualRecognition extends StatefulWidget {
  ScreenVisualRecognition({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenVisualRecognition createState() => new _ScreenVisualRecognition();
}

class _ScreenVisualRecognition extends State<ScreenVisualRecognition> {
  IamOptions options;
  File _image;
  String _text = "Obtain Image Description";
  String _text2 = "";
  String url;

  Future<Null> getOptions() async {
    this.options = await IamOptions(
        iamApiKey: "PtrgxzcADASVCXCjDmalrW1gXSADDgEt533gxwQAliAnvvjDDFmNHKNzgnLQ",
        url: "https://gateway.watsonplatform.net/visual-recognition/api")
        .build();
    print(this.options.accessToken);
    print(this.options);
  }

  @override
  void initState() {
    getOptions();
    super.initState();
  }

  void visualRecognitionUrl() async {
    //await getOptions();
    VisualRecognition visualRecognition = new VisualRecognition(
        iamOptions: this.options, language: Language.ENGLISH);
    ClassifiedImages classifiedImages =
    await visualRecognition.classifyImageUrl(this.url);
    print(classifiedImages
        .getImages()[0]
        .getClassifiers()[0]
        .getClasses()[0]
        .className);
    setState(() {
      _text = classifiedImages.getImages()[0].getClassifiers()[0].toString();

      _text2 = classifiedImages
          .getImages()[0]
          .getClassifiers()[0]
          .getClasses()[0]
          .className;


    });
  }

  void visualRecognitionFile() async {
    //await getOptions();
    VisualRecognition visualRecognition = new VisualRecognition(
        iamOptions: this.options, language: Language.ENGLISH);
    ClassifiedImages classifiedImages =
    await visualRecognition.classifyImageFile(_image.path.toString());

    print(classifiedImages
        .getImages()[0]
        .getClassifiers()[0]
        .getClasses()[0]
        .className);
    setState(() {
      _text = classifiedImages.getImages()[0].getClassifiers()[0].toString();
      _text2 = classifiedImages
          .getImages()[0]
          .getClassifiers()[0]
          .getClasses()[0]
          .className.toString();
    });
  }

  Future getPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height:MediaQuery.of(context).size.height/20,
                ),
                Text('Visual',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontSize: 70,
                  fontWeight: FontWeight.w600
                ),),
                Text('Recognition',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "lineto",
                  fontSize: 40,
                  fontWeight: FontWeight.w600
                ),),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10,vertical: 5),
                  child: _image == null
                      ? new Text('',
                    style: TextStyle(
                        fontSize: 30.0
                    ),)
                      : new Image.file(
                    _image,
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                 new Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text('Step 1:',
                  style: TextStyle(color: Colors.grey),),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:5.0),
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: getPhoto,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            SizedBox(
                              width:50
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add_a_photo), onPressed: getPhoto) ,
                            Text('Click a Photo',
                          style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),),
                          ],),
                      ),
                    ),
                    new Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text('Step 2:',
                  style: TextStyle(color: Colors.grey),),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal:5.0),
                  child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: visualRecognitionFile,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            SizedBox(
                              width:26
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.cloud_upload), onPressed: visualRecognitionFile) ,
                            Text('Analyze the image uploaded',
                          style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
              ),
                          ],),
                      ),    
                ),
                SizedBox(height: 15),
                 new Center(
                  child: Text('OR',
                  style: TextStyle(color: Colors.grey,
                  fontSize: 20,
                  ),
                  )
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal:5.0),
                  child: Text('Step 1:',
                  style: TextStyle(color: Colors.grey),),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal:5.0),
                  child: new TextField(
                    decoration: new InputDecoration(labelText: " Enter Image URL"),
                    onChanged: (String value) {
                      this.url = value.toString();
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                new Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text('Step 2:',
                  style: TextStyle(color: Colors.grey),),
                ),               

                new Container(
                  margin: const EdgeInsets.all(5.0),
                  child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: visualRecognitionUrl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            SizedBox(
                              width:40
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.cloud_upload), onPressed: visualRecognitionUrl) ,
                            Text('Analyze the image URL',
                          style: TextStyle(
                  color: Colors.white,
                  fontFamily: "lineto",
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),),
                          ],),
                      ), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

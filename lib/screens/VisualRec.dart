import 'dart:async';
import 'dart:io';
import 'dart:convert';
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
  String _text = "Loading";
  String _text2 = "Init";
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
    // TODO: implement initState
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
        title: Text("IBM Watson Visual Recognition"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? new Text('No image selected')
                  : new Image.file(
                _image,
                height: 300.0,
                width: 300.0,
              ),
              new RaisedButton(
                child: const Text('Click a photo'),
                onPressed: getPhoto,
              ),
              new Text("or"),
              new Container(
                margin: const EdgeInsets.all(5.0),
                child: new TextField(
                  decoration: new InputDecoration(labelText: "Enter Url Image"),
                  onChanged: (String value) {
                    this.url = value.toString();
                  },
                ),
              ),
              new Container(
                margin: const EdgeInsets.all(5.0),
                child: new Text(_text2,
                    style: new TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold)),
              ),
              new Container(
                margin: const EdgeInsets.all(5.0),
                child: new Text(_text),
              ),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                  child: const Text('Visual Recognition File'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: visualRecognitionFile,
                ),
              ),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                  child: const Text('Visual Recognition Url'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: visualRecognitionUrl,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

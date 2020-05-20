import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

class Chatbot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
                accentColor: Colors.blueGrey,
                fontFamily: 'lineto',
      ),
      home: ChatScreen(title: 'Virtual Assistance'),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _text;
  WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
    version: '2019-02-28',
    username: 'apikey',
    apikey: 'sP0X5MXVpULgpKmsDOunzRTLmTLxpN5Z-l3by3QMEWPY',
    assistantID: '5fc0f0f3-fe4f-41ee-80a6-38583233d418',
    url:
        'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/4db8f948-2e57-4cf2-ba99-22261f80958f/v2',
  );

  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  final myController = TextEditingController();

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
    _callWatsonAssistant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  title: Text('Virtual Assistance', 
      // style: TextStyle(
      // color: Colors.black87,
      // fontFamily: "lineto",
      // fontWeight: FontWeight.w300
      // ),),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.grey),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () {
              watsonAssistantContext.resetContext();
              setState(() {
                _text = null;
              });
            },
          )
        ],
      ),
      //drawer: AppDrawer(),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height:MediaQuery.of(context).size.height/10,
              ),
              Text('Virtual',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 70,
                fontWeight: FontWeight.w600
              ),),
              Text(' Assistance',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "lineto",
                fontSize: 45,
                fontWeight: FontWeight.w600
              ),),
              Divider(color: Colors.grey,),
              SizedBox(
                height:MediaQuery.of(context).size.height/20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _text != null ? '$_text' : 'Hey! How can I help you?',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),
              TextField(
                autocorrect: true,
                controller: myController,
                decoration: InputDecoration(
                  hintText: 'Ask me anything!',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                      onPressed: _callWatsonAssistant),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

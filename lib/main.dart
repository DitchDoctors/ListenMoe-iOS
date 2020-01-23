import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Controllers/main_radio.dart';
import 'package:listenmoe/Controllers/timer.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'dart:core';
import 'package:web_socket_channel/io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Models/radio_model.dart';
import 'constants.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color(0xFF17162E),
        body: Center(
            child: new Container(
                margin: const EdgeInsets.all(15.0),
                child: new SingleChildScrollView(
                    child: Column(children: <Widget>[
                  //     SizedBox(height: 55),
                  Text("Select your style!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 15),
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Colors.red,
                      child: Text('JPop',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return new Jpop();
                          }));
                        }
                      }),
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Colors.red,
                      child: Text('KPop',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return new Kpop();
                          }));
                        }
                      }),
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Colors.red,
                      child: Text('FAQ',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return new FAQ();
                          }));
                        }
                      }),
                ])))));
  }
}








class Jpop extends StatefulWidget  {
  @override
  _JpopState createState() => _JpopState();
}
 const int heartbeat = 35;
class _JpopState extends State<Jpop> {

  SongInfo _songInfo;
  
  
  @override 
  void dispose() {
    super.dispose();
    FlutterRadio.stop();
  }
  // final channel2 = IOWebSocketChannel.connect('wss://listen.moe/gateway_v2',
  //     pingInterval: Duration(seconds: 3));
  String url = "https://listen.moe/fallback";

  final radio = MainRadio();


  @override
  void initState() {
    super.initState();
    audioStart();

    const beat = const Duration(seconds: heartbeat);
    Timer.periodic(beat, (_) => radio.keepAlive(true));

  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart()
    .whenComplete(() => FlutterRadio.play(url: url));
  
  }
  

  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: new Color(0xFF17162E),
      appBar: AppBar(backgroundColor: new Color(0xFF17162E)),
      body: Center(
        child: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new SingleChildScrollView(
              child: Column(children: <Widget>[
                new Text(
                  "Title",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder<SongInfo>(
                  stream: radio.songData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                        return Column(
                          children: <Widget>[

                     Text(
                      snapshot.hasData
                          ? '${snapshot.data.d.song.title}'
                          : 'Unable to fetch data. Please try again shortly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),



                new Text(
                  "Artist",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                          Text(
                              '${snapshot.data.d.song.artists?.first?.name ?? '???'}', 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            // fontWeight: FontWeight.bold,
                          ),
                    ),
                          ],
                        );
                                            
                    }
                    return Center(
                    child: Text('The stream could not be returned'),
                  );
                  
                  },
                   
                ),
                     
            
                
                
                SizedBox(
                  height: 7,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  child: Text('Play',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () async { 
                      bool playing = await FlutterRadio.isPlaying();
                      if (!playing)
                        FlutterRadio.play(url: url);
                  }
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  child: Text('Pause',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () async  { 
                   bool playing = await FlutterRadio.isPlaying();
                      if (playing)
                        FlutterRadio.pause(url: url);
                  },
                ),
              ]),
            )),
      ),
    );
  }
}

class Kpop extends StatefulWidget {
  @override
  _KpopState createState() => _KpopState();
}

class _KpopState extends State<Kpop> {
  final channel =
      IOWebSocketChannel.connect('wss://listen.moe/kpop/gateway_v2');
  final channel2 =
      IOWebSocketChannel.connect('wss://listen.moe/kpop/gateway_v2');
  var songInfo;
  String url = "https://listen.moe/kpop/fallback";

  @override
  void initState() {
    super.initState();
    audioStart();
        FlutterRadio.stop();


    
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  moeColor,
        appBar: AppBar(backgroundColor: new Color(0xFF17162E)),
        body: Center(
          child: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new SingleChildScrollView(
                child: Column(
              children: <Widget>[
                new Text(
                  "Title",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? '${new SongInfo.fromJson(jsonDecode(snapshot.data)).d.song.title}'
                          : 'Unable to fetch data. Please try again shortly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                new Text(
                  "Artist",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder(
                  stream: channel2.stream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? '${new SongInfo.fromJson(jsonDecode(snapshot.data)).d.song.artists.first.name}'
                          : 'Unable to fetch data. Please try again shortly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 7,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  child: Text('Play',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () => FlutterRadio.play(url: url),
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  child: Text('Pause',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () => FlutterRadio.pause(url: url),
                ),
              ],
            )),
          ),
        ));
  }
}

class FAQ extends StatefulWidget {
  @override
  _FAQ createState() => _FAQ();
}

class _FAQ extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: new Color(0xFF17162E),
        appBar: AppBar(backgroundColor: new Color(0xFF17162E)),
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: ListView(padding: EdgeInsets.all(30.0), children: <Widget>[
              Text("Q Is this [app] offical",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "A This app is unoffical but the Listen Moe dev has given permission ^^",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              Text(
                  "Q On the site i can login and add favorites and such where is that option?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "A Im new to programming so that stuff will be added but itll take time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              Text("Q How can i report a bug?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "A You can email me at Support@hentaiglare.com Or post in the listen.moe discord and tag @DitchDoctor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              Text("Q Is this legal? How do you get the data?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "A The short answer is We dont host any content its all taken from Listen.Moe our app is both safe and legal :) ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(
                height: 7,
              ),
              Text(
                  "Now for the legal answer We take the info and streams from websites and make it easier for users to find great music and stream it. This app and any of it's staff/developers don't host any of the content found inside it. Any and all images, streams and information found on the app are taken from it's source Listen.moe This app or it's owner (DitchDoctor) isn't liable for any misuse of any of the contents found inside or outside of the app and cannot be held responsible for the distribution of any of the contents found inside the app.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              Text(
                  "Q: Why doesnt the artist/title info refresh unless I back out and renter the page?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "I forgot to add the code that keeps the connection open. It will be fixed soon :)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              Text("Q: I like/love the app and wanna donate.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "I am thankful for all donations as I code in my freetime and don't get paid. You can donate to me to encourage me to work on the app, and pay for the certificate to keep it on the app store using the button below. You can also donate to the site that we get our data from at listen.moe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              new RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: Colors.red,
                child: Text('Paypal',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: _paypal,
              ),
            ])));
  }
}

_paypal() async {
  const url = 'https://paypal.me/HentaiGlare';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



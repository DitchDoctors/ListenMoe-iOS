import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Controllers/main_radio.dart';
import 'package:listenmoe/Controllers/player_controller.dart';
import 'package:listenmoe/Models/enums.dart';
import 'package:listenmoe/Requests/listenMoe+requests.dart';
import 'package:listenmoe/constants.dart';
import 'dart:async';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'Models/player.dart';
import 'Models/radio_model.dart';

ThemeData get _appTheme => ThemeData(
      scaffoldBackgroundColor: moeColor,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        subhead: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        subtitle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    );
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';


void main() {
  runApp(MaterialApp(
    theme: _appTheme,
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
                            return PlayerController(radioChoice: RadioChoice.jpop,);
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
                             return PlayerController(radioChoice: RadioChoice.kpop,);
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



class FAQ extends StatefulWidget {
  @override
  _FAQ createState() => _FAQ();
}

class _FAQ extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: moeColor,
        appBar: AppBar(
          backgroundColor: moeColor,
        ),
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
           /*    Text(
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
              ), */
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


class SongInfo {
  int op;
  D d;
  String t;

  SongInfo({this.op, this.d, this.t});

  factory SongInfo.fromJson(Map<String, dynamic> parsedJson) {
    return SongInfo(
        op: parsedJson['op'],
        d: D.fromJson(parsedJson['d']),
        t: parsedJson['t']);
  }
}

class D {
  SongArtist artist;
  Song song;
  dynamic requester;
  dynamic event;
  String startTime;
  List<LastPlayed> lastPlayed;
  int listeners;
  D(
      {this.song,
      this.requester,
      this.event,
      this.startTime,
      this.lastPlayed,
      this.listeners,
      this.artist});
  factory D.fromJson(Map<String, dynamic> parsedJson) {
    return D(
        song: Song.fromJson(parsedJson['song']),
        artist: SongArtist.fromJson(parsedJson['song'])
        /*requester : parsedJson['requester'],
        event : parsedJson ['event'],
        startTime: parsedJson['startTime'],
        lastPlayed : parsedJson[LastPlayed.fromJson(parsedJson['lastPlayed'])],
        listeners : parsedJson ['listeners']
        */
        );
  }
}

class LastPlayed {
  int id;
  String title;
  List<dynamic> sources;
  List<LastPlayedArtist> artists;
  List<Album> albums;
  int duration;

  LastPlayed({
    this.id,
    this.title,
    this.sources,
    this.artists,
    this.albums,
    this.duration,
  });

  factory LastPlayed.fromJson(Map<String, dynamic> parsedJson) {
    return LastPlayed(
        id: parsedJson['id'],
        title: parsedJson['title'],
        sources: parsedJson['sources'],
        artists: parsedJson['artists'],
        albums: parsedJson['albums'],
        duration: parsedJson['duration']);
  }
}

class Album {
  int id;
  String name;
  dynamic nameRomaji;
  String image;

  Album({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });

  factory Album.fromJson(Map<String, dynamic> parsedJson) {
    return Album(
        id: parsedJson['id'],
        name: parsedJson['name'],
        nameRomaji: parsedJson['nameRomaji'],
        image: parsedJson['image']);
  }
}

class LastPlayedArtist {
  int id;
  String name;
  String nameRomaji;
  String image;

  LastPlayedArtist({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });
}

class Song {
  int id;
  String title;
  List<dynamic> sources;
  List<SongArtist> artists;
  List<Album> albums;
  int duration;

  Song({
    this.id,
    this.title,
    this.sources,
    this.artists,
    this.albums,
    this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        //  id: parsedJson['id'],
        title: parsedJson['title'],
        //   sources : parsedJson ['sources'],
        artists: List<SongArtist>.from(
            parsedJson['artists'].map((x) => SongArtist.fromJson(x)))
        //   albums : parsedJson[Album.fromJson(parsedJson['albums'])],
        //  duration : parsedJson ['duration']
        );
  }
}

class SongArtist {
  int id;
  String name;
  String nameRomaji;
  String image;

  SongArtist({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });
  factory SongArtist.fromJson(Map<String, dynamic> parsedJson) {
    return SongArtist(
        //   id: parsedJson['id'],
        name: parsedJson['name']);
    //    nameRomaji: parsedJson['nameRomaji'],
    //    image: parsedJson['image']);
  }
}


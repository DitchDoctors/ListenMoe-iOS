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
import 'package:listenmoe/Pages/FAQ.dart';
import 'package:listenmoe/Pages/Credits.dart';

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
                            return PlayerController(
                              radioChoice: RadioChoice.jpop,
                            );
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
                            return PlayerController(
                              radioChoice: RadioChoice.kpop,
                            );
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
                            return FAQ();
                          }));
                        }
                      }),
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Colors.red,
                      child: Text('Credits',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return Credits();
                          }));
                        }
                      }),
                ])))));
  }
}
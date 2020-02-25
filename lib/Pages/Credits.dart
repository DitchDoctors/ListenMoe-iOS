import 'package:flutter/material.dart';
import 'package:listenmoe/constants.dart';
import 'dart:core';

class Credits extends StatefulWidget {
  @override
  _Credits createState() => _Credits();
}

class _Credits extends State<Credits> {
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
              new Container(
                  width: 75.0,
                  height: 300.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://creepymc.com/ditch.gif")))),
              SizedBox(height: 5),
              Text("DitchDoctor (Lead Dev)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "Hello. Im not sure what to put here. Thank you so much for downloading my first appstore app!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              new Container(
                  width: 75.0,
                  height: 300.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://creepymc.com/festive.gif")))),
              SizedBox(height: 5),
              Text("FestiveDumpling (Co-Dev)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "Ditch is gonna buy me a Tesla one day",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              new Container(
                  width: 75.0,
                  height: 300.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://creepymc.com/doll.gif")))),
              SizedBox(height: 5),
              Text("Doll (DitchDoctors Girlfriend)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "(She didnt tell me what to put here yet sooooo) Doll has always been there for me from the beginning. Providing encouragement and the like. Not sure what else to say.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(height: 20),
              new Container(
                  width: 75.0,
                  height: 300.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://creepymc.com/bk.gif")))),
              SizedBox(height: 5),
              Text("BlackKnit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "Stay hungry, stay sad",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
            ])));
  }
}

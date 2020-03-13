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
                              "https://cdn.discordapp.com/avatars/475756899992731648/a_afcbf6d168662b577a1a34d9223f1dde.gif?size=256&f=.gif")))),
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
                              "https://cdn.discordapp.com/avatars/169279823464628224/5c6469314d8d23bd275928a5f89c7b42.png?size=256")))),
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
                              "https://cdn.discordapp.com/avatars/564762872521949191/a_6a3d4fc86e126598a91633a000dc3eab.gif?size=256&f=.gif")))),
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
                              "https://cdn.discordapp.com/avatars/425097102910291968/8c9f88efc033097af860e125f84d9f48.png?size=256")))),
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

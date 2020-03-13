import 'package:flutter/material.dart';
import 'package:listenmoe/constants.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

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
                  "A You can post in the listen.moe discord and tag @DitchDoctor Or join my development server below",
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
              /*              SizedBox(height: 20),
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
                  )), */
              SizedBox(height: 20),
              Text("Q: I like/love the app and wanna donate.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "Thank you for the interest! Theres a paypal link at the bottom!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(
                height: 20,
              ),
              /*      new RaisedButton(
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
              Text(
                  "Q Are there any cool plans for the app that arent mentioned here?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 7),
              Text(
                  "A Yes! When we hit 1k active users there will be a big giveaway on my development discord! And we (Festive and I) plan to add every feature from the site! ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              SizedBox(
                height: 20,
              ),
              new RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: Colors.red,
                child: Text('Join our discord!',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: _discord,
              ),
                            new RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: Colors.red,
                child: Text('Donate',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: _dono,
              ),
            ])));
  }
}

_discord() async {
  const url = 'https://discord.gg/ccnNhBw';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_dono() async {
  const url = 'https://paypal.me/DitchDoctor';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


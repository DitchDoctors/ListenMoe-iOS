import 'package:flutter/material.dart';
import 'package:listenmoe/Controllers/log_in_controller.dart';
import 'package:listenmoe/Controllers/player_controller.dart';
import 'package:listenmoe/Models/enums.dart';
import 'package:listenmoe/Pages/Credits.dart';
import 'package:listenmoe/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
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

Widget _frontDoor;

//TODO: Needs Proper init
SharedPreferences pref;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await _checkIfLoggedIn();

  runApp(MaterialApp(
    theme: _appTheme,
    home: HomePage(),
  ));
}

//Future _checkIfLoggedIn() async {
// pref = await SharedPreferences.getInstance();
// if (pref.getString(userToken) != null) {
//   _frontDoor = PlayerController(radioChoice: RadioChoice.jpop);
// } else
// _frontDoor = LoginController();
// }

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
                  Text("Placeholder for the login screen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Press continue for the streams",
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
                      child: Text('Continue',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => PlayerController(
                                      radioChoice: RadioChoice.jpop)));
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
                            return new Credits();
                          }));
                        }
                      }),
                ])))));
  }
}

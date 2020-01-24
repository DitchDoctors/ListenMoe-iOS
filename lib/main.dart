import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Controllers/main_radio.dart';
import 'package:listenmoe/Requests/listenMoe+requests.dart';
import 'package:listenmoe/constants.dart';
import 'dart:async';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'Controllers/player.dart';
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

void main() {
  runApp(MaterialApp(
    theme: _appTheme,
    home: HomePage(),
  ));
}

final Player _player = Player();
void _beginBackgroundPlayback() async {
    _player.audioStart();
    AudioServiceBackground.run(() => _player);

    
  
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
                          // Navigator.of(context).push(MaterialPageRoute<Null>(
                          //     builder: (BuildContext context) {
                          //   return new Kpop();
                          // }));
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

const int heartbeat = 35;
bool _isPlaying = true;

class Jpop extends StatefulWidget {
  @override
  _JpopState createState() => _JpopState();
}

class _JpopState extends State<Jpop> {
    
  @override
  void dispose() {
    super.dispose();
    FlutterRadio.stop();
    _isPlaying = true;
  }

  // final channel2 = IOWebSocketChannel.connect('wss://listen.moe/gateway_v2',
  //     pingInterval: Duration(seconds: 3));

  final radio = MainRadio();

  @override
  void initState() {
    super.initState();
    _beginBackgroundPlayback();

    const beat = const Duration(seconds: heartbeat);
    Timer.periodic(beat, (_) => radio.keepAlive(true));
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: moeColor,
        elevation: 0,
      ),
      body: StreamBuilder<SongInfo>(
          stream: radio.songData,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              SongInfo _songData = snapshot.data;

              return new Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: SafeArea(
                    top: true,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 206,
                                width: 206,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0)),
                                  color: moeColor,
                                  elevation: 2,
                                  child: ((_songData
                                                  .d.song.albums?.isNotEmpty ??
                                              false) &&
                                          _songData.d.song.albums?.first
                                                  ?.image !=
                                              null)
                                      ? Image.network(
                                          'https://cdn.listen.moe/covers/${_songData.d.song.albums.first.image}',
                                          headers: ListenMoeRequests.headers,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child, percentage) {
                                            if (percentage == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: percentage
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? percentage
                                                            .cumulativeBytesLoaded /
                                                        percentage
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          listenMoeIcon,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 30),
                                    child: Text(
                                      snapshot.hasData
                                          ? '${snapshot.data.d.song.albums.isNotEmpty ? snapshot.data.d.song.albums.first.nameRomaji ?? snapshot.data.d.song.title  : snapshot.data.d.song.title}'
                                          : 'Unable to fetch data. Please try again shortly',
                                      style: Theme.of(context).textTheme.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data.d.song.artists?.first?.name ?? '???'}',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100.0),
                                child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  onPressed: () => setState(() {
                                    _isPlaying = !_isPlaying;
                                    FlutterRadio.playOrPause(url: moeURL);
                                  }),
                                  child: _isPlaying
                                      ? Icon(Icons.pause)
                                      : Icon(Icons.play_arrow),
                                ),
                              ),
                            ]),
                        DraggableScrollableSheet(
                          initialChildSize: 0.11,
                          minChildSize: 0.11,
                          maxChildSize: 0.5,
                          expand: false,
                          builder: (context, controller) =>
                              SingleChildScrollView(
                            controller: controller,
                            child: Container(
                              color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 75,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 63,
                                            width: 63,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                              elevation: 6,
                                              child: Image.asset(
                                                listenMoeIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                                                                      child: Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Last Played',
                                                    style: Theme.of(context).textTheme.subtitle,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'Past data to be placed here, but thats not all hence we add more data, and if thats not the case it fades',
                                                    style: Theme.of(context).textTheme.subtitle,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 275,
                                                                      child: ListView.builder(
                                                                        physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.d.lastPlayed?.length ?? 0,
                                      itemBuilder: (context, index) => 
                                      Container(
                                        height: 50,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }
            return Center(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 25,
                ),
                Text('Buffering Stream...',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ));
          }),
    );
  }
}

// class Kpop extends StatefulWidget {
//   @override
//   _KpopState createState() => _KpopState();
// }

// class _KpopState extends State<Kpop> {
//   final channel =
//       IOWebSocketChannel.connect('wss://listen.moe/kpop/gateway_v2');
//   final channel2 =
//       IOWebSocketChannel.connect('wss://listen.moe/kpop/gateway_v2');
//   var songInfo;
//   String url = "https://listen.moe/kpop/fallback";

//   @override
//   void initState() {
//     super.initState();
//     audioStart();
//         FlutterRadio.stop();

//   }

//   Future<void> audioStart() async {
//     await FlutterRadio.audioStart();
//     print('Audio Start OK');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor:  moeColor,
//         appBar: AppBar(backgroundColor: new Color(0xFF17162E)),
//         body: Center(
//           child: new Container(
//             margin: const EdgeInsets.all(15.0),
//             child: new SingleChildScrollView(
//                 child: Column(
//               children: <Widget>[
//                 new Text(
//                   "Title",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 StreamBuilder(
//                   stream: channel.stream,
//                   builder: (context, snapshot) {
//                     return Text(
//                       snapshot.hasData
//                           ? '${new SongInfo.fromJson(jsonDecode(snapshot.data)).d.song.title}'
//                           : 'Unable to fetch data. Please try again shortly',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22.0,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     );
//                   },
//                 ),
//                 new Text(
//                   "Artist",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 StreamBuilder(
//                   stream: channel2.stream,
//                   builder: (context, snapshot) {
//                     return Text(
//                       snapshot.hasData
//                           ? '${new SongInfo.fromJson(jsonDecode(snapshot.data)).d.song.artists.first.name}'
//                           : 'Unable to fetch data. Please try again shortly',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22.0,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 RaisedButton(
//                   shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.red,
//                   child: Text('Play',
//                       style: TextStyle(
//                           fontSize: 23.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                   onPressed: () => FlutterRadio.play(url: url),
//                 ),
//                 RaisedButton(
//                   shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.red,
//                   child: Text('Pause',
//                       style: TextStyle(
//                           fontSize: 23.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                   onPressed: () => FlutterRadio.pause(url: url),
//                 ),
//               ],
//             )),
//           ),
//         ));
//   }
// }

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

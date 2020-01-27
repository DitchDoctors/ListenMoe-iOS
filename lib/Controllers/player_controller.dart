import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Animator/flip_cards.dart';
import 'package:listenmoe/Models/enums.dart';
import 'package:listenmoe/Models/player.dart';
import 'package:listenmoe/Models/radio_model.dart';

import '../constants.dart';
import 'main_radio.dart';

class PlayerController extends StatefulWidget {
  final RadioChoice radioChoice;
  final int heartbeat = 35;
  PlayerController({@required this.radioChoice, Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PlayerStateController(radioChoice);
}

class _PlayerStateController extends State<PlayerController> {
  bool _isPlaying = true;
  Player _player;
  MainRadio _radio;
  _PlayerStateController(RadioChoice choice) {
    _radio = MainRadio(radioChoice: choice);
  }

  void initState() {
    super.initState();
    _player =
        Player(url: widget.radioChoice == RadioChoice.jpop ? jpopURL : kpopURL);

    //Beat heart as soon as audio starts;
    _player.audioStart().whenComplete(() => Timer.periodic(
        Duration(seconds: widget.heartbeat), (_) => _radio.keepAlive(true)));
  }

  @override
  void dispose() {
    super.dispose();
    FlutterRadio.stop();
    _isPlaying = true;
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.radioChoice == RadioChoice.jpop ? jpopURL : kpopURL;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: moeColor,
        elevation: 0,
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(listenMoeIcon),
            ),
          ),
        ),
      ),
      body: StreamBuilder<SongInfo>(
          stream: _radio.songData,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FlipCards(
                                  songData: _songData,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 8, 30),
                                      child: Text(
                                        snapshot.hasData
                                            ? '${snapshot.data.d.song.albums.isNotEmpty ? snapshot.data.d.song.albums.first.nameRomaji ?? snapshot.data.d.song.title : snapshot.data.d.song.title}'
                                            : 'Unable to fetch data. Please try again shortly',
                                        style:
                                            Theme.of(context).textTheme.title,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.d.song.artists?.first?.name ?? '???'}',
                                      style:
                                          Theme.of(context).textTheme.subhead,
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
                                      FlutterRadio.playOrPause(url: url);
                                    }),
                                    child: _isPlaying
                                        ? Icon(Icons.pause)
                                        : Icon(Icons.play_arrow),
                                  ),
                                ),
                              ]),
                        ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 63,
                                            width: 63,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              elevation: 6,
                                              child: Image.asset(
                                                listenMoeIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 5, 5, 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Last Played',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'Past data to be placed here, but thats not all hence we add more data, and if thats not the case it fades',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle,
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
                                      itemCount:
                                          snapshot.data.d.lastPlayed?.length ??
                                              0,
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

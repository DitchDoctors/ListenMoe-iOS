import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Animator/flip_cards.dart';
import 'package:listenmoe/Animator/gradient_background.dart';

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

  Player _player; // Dart Analyzer won't stop crying here
  MainRadio _radio;
  RadioChoice _radioChoice;
  _PlayerStateController(RadioChoice choice) {
    _radioChoice = choice;
    _radio = MainRadio(radioChoice: choice);
  }

  ValueNotifier<bool> _notifier;

  void initState() {
    super.initState();
    _notifier = ValueNotifier<bool>(_isPlaying);
    _changeStations(_radioChoice, shouldStop: false);
    _heartBeater();
    
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  void _dispose() async {
    _isPlaying = true;
    if (await FlutterRadio.isPlaying()) {
      FlutterRadio.stop();
    }
  }

  void _changeStations(RadioChoice choice, {bool shouldStop = true}) async {
    _isPlaying = false;
    setState(() => _radioChoice = choice);
    if (shouldStop) if (await FlutterRadio.isPlaying()) FlutterRadio.stop();
    _player = Player(url: _radioChoice == RadioChoice.jpop ? jpopURL : kpopURL)
      ..audioStart();

    _radio = MainRadio(radioChoice: choice);
    await FlutterRadio.isPlaying().then((_) => _isPlaying = _);
  }

  //Beat heart as soon as audio starts; Must call only once!
  void _heartBeater() {
    Timer.periodic(
        Duration(seconds: widget.heartbeat), (_) => _radio.keepAlive(true));
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.radioChoice == RadioChoice.jpop ? jpopURL : kpopURL;
    return Scaffold(
        body: StreamBuilder<SongInfo>(
            stream: _radio.songData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                SongInfo _songData = snapshot.data;

                return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: CoverGradientBackground(songInfo: _songData),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: AppBar().preferredSize.height),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
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
                                    padding:
                                        const EdgeInsets.only(bottom: 100.0),
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        FlutterRadio.playOrPause(url: url);
                                        _notifier.value = !_notifier.value;
                                      },
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: _notifier,
                                        builder: (context, value, _) {
                                          return value
                                              ? Icon(Icons.pause)
                                              : Icon(Icons.play_arrow);
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          DraggableScrollableSheet(
                            initialChildSize: 0.11,
                            minChildSize: 0.11,
                            maxChildSize: 0.35,
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
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
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
                                                        BorderRadius.circular(
                                                            6)),
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
                                                      'Last Played Items',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .title,
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snapshot
                                                  .data.d.lastPlayed?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            if (snapshot.data.d.lastPlayed !=
                                                    null &&
                                                snapshot.data.d.lastPlayed
                                                    .isNotEmpty) {
                                              var item = snapshot
                                                  .data.d.lastPlayed[index];
                                              var time = Duration(
                                                  seconds: item.duration);
                                              return ListTile(
                                                title: Text(item.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subhead),
                                                leading: CircleAvatar(
                                                  backgroundImage: item.albums
                                                              .isNotEmpty &&
                                                          item.albums?.first
                                                                  ?.image !=
                                                              null
                                                      ? NetworkImage(
                                                          'https://cdn.listen.moe/covers/${item.albums?.first?.image}')
                                                      : AssetImage(
                                                          listenMoeIcon),
                                                ),
                                                trailing: Text(
                                                    '${time.inMinutes} minutes ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle),
                                              );
                                            }
                                            return Container();
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: AppBar(
                        backgroundColor: Colors.transparent,
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
                        actions: [
                          PopupMenuButton(
                            color: moeColor,
                            icon: Icon(Icons.radio),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: RadioListTile<RadioChoice>(
                                activeColor: Colors.red,
                                title: Text(
                                  'JPop',
                                ),
                                onChanged: (value) {
                                  Navigator.of(context).pop();
                                  _changeStations(value);
                                },
                                value: RadioChoice.jpop,
                                groupValue: _radioChoice,
                              )),
                              PopupMenuItem(
                                  child: RadioListTile<RadioChoice>(
                                activeColor: Colors.red,
                                title: Text(
                                  'KPop',
                                ),
                                onChanged: (value) {
                                  //setState(() => _radio = MainRadio(radioChoice: value));
                                  Navigator.of(context).pop();
                                  _changeStations(value);
                                },
                                value: RadioChoice.kpop,
                                groupValue: _radioChoice,
                              ))
                            ],
                          ),
                        ]),
                  ),
                ],
              );
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

              
            })
            );
  }
}

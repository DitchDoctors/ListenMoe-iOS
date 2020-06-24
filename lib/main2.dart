
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:listenmoe/Components/backgroundSplash.dart';
import 'package:listenmoe/Components/infoContainer.dart';
import 'package:listenmoe/Components/musicDiscContainer.dart';

import 'Controllers/main_radio.dart';
import 'Models/enums.dart';
import 'Models/player.dart';
import 'Models/radio_model.dart';
import 'constants.dart';
import 'constants.dart';



class Main2 extends StatefulWidget {

  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
  Main2({Key key}) :super(key: key);

  @override
  _Main2State createState() => _Main2State();
}

class _Main2State extends State<Main2> {
  
  RadioChoice choice = RadioChoice.jpop;
  MainRadio _radio;
  Player _player;
  
  @override
  void initState() {
    super.initState();
  // _radio = MainRadio(radioChoice: choice);
  // _player = Player(url: choice == RadioChoice.jpop ? jpopURL: kpopURL)
  //   ..audioStart().whenComplete(() => Timer.periodic(
  //       Duration(seconds: 35), (_) => _radio.keepAlive(true)));
    _switchStation(choice);
  }
  

  @override
  void dispose() {
    super.dispose();
    _player.stop();
  }

  _switchStation(RadioChoice choice) {
    if (widget._isPlaying.value) FlutterRadio.stop();
    this.setState(() {
      _radio = MainRadio(radioChoice: choice); 
      choice = choice;     
    });
  _player = Player(url: choice == RadioChoice.jpop ? jpopURL: kpopURL)
    ..audioStart().whenComplete(() => {
      Timer.periodic(
        Duration(seconds: 35), (_) => _radio.keepAlive(true)),
        widget._isPlaying.value = true,
    });

  }

  Widget _population(SongInfo data) {
     final _data = data;
    var _cover = listenMoeImagePrefix;
    try {
      final _covers = _data.d.song.albums.first.image; 
      _cover += _covers;
    } catch (e) {
      _cover = null;
    }
          return Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
           BackgroundSplash(
             url: _cover,),
            Column(       
            crossAxisAlignment: CrossAxisAlignment.stretch,  
          children: [
            SizedBox(height: 25,),
            MusicDiscContainer(
              url: _cover,
            ),
            Spacer(),
            ValueListenableBuilder(
              valueListenable: widget._isPlaying,
              builder: (context, value,child) {
                return InfoContainer(
              data: _data,
              playing: value,
              onPopBack: () {
                FlutterRadio.playOrPause(url:  choice == RadioChoice.jpop ? jpopURL: kpopURL);
                widget._isPlaying.value = !widget._isPlaying.value;
              }
            );
              }
            ),
            SizedBox(height: 25,)
          ]
        ),
          ],
        )
      );
  }

  List<Widget> _choiceItem() {
    return RadioChoice.values.map((i) {
      var text = '';
      if (i == RadioChoice.jpop) {
        text = 'JPop';
      } else 
      text = "KPop";

      return  GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          this._switchStation(i);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19
            )),
            choice == i ? Icon(Icons.check_circle, color: moeColorRed) : Container()
          ],
        
      ),
        )
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.radio, color: Colors.white), onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: moeColor,
              isScrollControlled: true,
              builder: (context)  {
                return FractionallySizedBox(
                  heightFactor: 0.15,
                  child: Container(
                  child: ListView(
                    children:_choiceItem(),
                  )
                )
                );
              });
          })
      ),
      body: StreamBuilder(
        stream: _radio.songData,
        builder: (BuildContext context, AsyncSnapshot<SongInfo> snapshot) {
         if (snapshot.data == null) return Container();
         return _population(snapshot.data);
        }
      )
    );

  }
}



import 'package:flutter/material.dart';

import '../Models/player.dart';
import '../Models/radio_model.dart';
import '../constants.dart';

class InfoContainer extends StatelessWidget  {
  final SongInfo data;
  final bool playing;
  final VoidCallback onPopBack;
  InfoContainer({Key key, this.data,this.playing, this.onPopBack}) : super(key: key);



  @override
  Widget build(BuildContext context) { 
    final theme = Theme.of(context).textTheme;
    final _data = data;
    print(_data);
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: EdgeInsets.only(top: 15,),
      child: Column(
        children:<Widget>[
          Text(_data.d.song.title, style: theme.title,),
          Text(_data.d.song.artists.first.name, style: theme.subtitle1),
          Spacer(),
          FloatingActionButton(
            onPressed: () =>  onPopBack.call(),
            child: Icon(playing ? Icons.pause : Icons.play_arrow, size: 35,),
            backgroundColor: moeColorRed,  
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text((_data.d.listeners?.toString() ?? "???")+ " Listeners" ,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,  
              )
            ),
          )
        ]
      ),
    );
  }

}
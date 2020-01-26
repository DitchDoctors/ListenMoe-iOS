import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:listenmoe/Models/enums.dart';
import 'package:listenmoe/Models/radio_model.dart';
import 'package:listenmoe/constants.dart';
import 'package:web_socket_channel/io.dart';


//class MainRadio = _MainRadio with _$MainRadio;

mixin _Transformer on Object {
  var streamer = StreamTransformer<dynamic, SongInfo>.fromHandlers(
    handleData: (data, newData) {
      if (data.contains('"op":1') && data.length > 15) {
      var decoded = json.decode(data);
      newData.add(SongInfo.fromJson(decoded));

      }
      
    }
  );

}


 class MainRadio extends Object with _Transformer  {
   final RadioChoice radioChoice;
   IOWebSocketChannel channel;
   MainRadio({@required this.radioChoice})  {
   channel = IOWebSocketChannel.connect(radioChoice == RadioChoice.jpop ? jpopSocket : kpopSocket , pingInterval: const Duration(seconds: 8));
   }

  


  Stream<SongInfo> get songData => channel.stream.transform(streamer);


   Future<void> keepAlive(bool shouldBeat) {
    if (shouldBeat) {
      channel.sink.add('{"op":9}');
    }
    return null;
  }



 

}
import 'dart:async';
import 'dart:convert';
import 'package:listenmoe/Models/radio_model.dart';
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
  final channel = IOWebSocketChannel.connect('wss://listen.moe/gateway_v2', pingInterval: const Duration(seconds: 8));


  Stream<SongInfo> get songData => channel.stream.transform(streamer);


   Future<void> keepAlive(bool shouldBeat) {
    if (shouldBeat) {
      channel.sink.add('{"op":9}');
    }
    return null;
  }



 

}
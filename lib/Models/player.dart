import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_radio/flutter_radio.dart';

class Player extends BackgroundAudioTask {

  String url;
<<<<<<< Updated upstream
  bool _playing;
=======
  bool _playing = false;
>>>>>>> Stashed changes

  Player({this.url});
//  Completer _completer = Completer();

   Future<void> audioStart() async {
    await FlutterRadio.audioStart()
<<<<<<< Updated upstream
        .whenComplete(() => FlutterRadio.play(url: url));
=======
        .whenComplete(() { FlutterRadio.play(url: url); _playing = true; });
>>>>>>> Stashed changes
  }




    playPause() {
      if (_playing)
        pause();
      else
        play();
    }

  play() {
    FlutterRadio.play(url: url);
    _playing = true;
    AudioServiceBackground.setState(
      controls: [],
      basicState: BasicPlaybackState.playing,
    );
  }

    pause() {
      FlutterRadio.playOrPause(url: url);
      _playing = false;
      AudioServiceBackground.setState(
        controls: [],
        basicState: BasicPlaybackState.paused,
      );

    }

    stop() {
      _playing = false;
      FlutterRadio.stop();
      AudioServiceBackground.setState(
        controls: [],
        basicState: BasicPlaybackState.stopped
      );
    
  }

  @override
  Future<void> onStart() {
    print('beginning');
    return run();
  }

  Future<void> run() async {
    MediaItem _mediaItem = MediaItem(
      id: 'moe_id_1',
      album: 'ListenMoe',
      title: '24/7 Radio',
    );
    AudioServiceBackground.setMediaItem(_mediaItem);
    audioStart();
    play();
   // await _completer.future;
  }

  @override
  void onStop() {
    stop();
  }

  


}
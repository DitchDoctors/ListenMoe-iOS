import 'package:flutter/material.dart';
import 'package:listenmoe/Models/radio_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:simple_animations/simple_animations.dart';

import '../constants.dart';

class CoverGradientBackground extends StatelessWidget {
  final SongInfo songInfo;

  CoverGradientBackground({this.songInfo}) {
    _generateColors();
  }

  final ValueNotifier<List<Color>> _gradientGen = ValueNotifier([]);

  _generateColors() async {
    if (songInfo.d.song.albums.isNotEmpty && songInfo.d.song.albums.first.image != null) {
      final _provider =
          NetworkImage(listenMoeCover + songInfo.d.song.albums.first.image);
      var paltte = await PaletteGenerator.fromImageProvider(_provider);
      _gradientGen.value += paltte.colors.toList();
      if (paltte.dominantColor?.color  != null) _gradientGen.value.insert(0, paltte.dominantColor?.color);
      if (paltte.lightVibrantColor?.color != null) _gradientGen.value.insert(_gradientGen.value.length, paltte.lightVibrantColor?.color);
      _gradientGen.value = _gradientGen.value; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Color>>(
        valueListenable: _gradientGen,
        builder: (context, value, _) {
          if (value != null && value.isNotEmpty) {
            final _tween = MultiTrackTween([
              Track('color1').add(const Duration(seconds: 8),
                  ColorTween(begin: value.first, end: value.last)),
              Track('color2').add(const Duration(seconds: 8),
                  ColorTween(begin: value.last, end: value.first)),
            ]);

            return ControlledAnimation(
              duration: _tween.duration,
              playback: Playback.MIRROR,
              tween: _tween,
              builder: (
                contet,
                animation,
              ) =>
                  Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [animation['color1'], animation['color2']],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
            );
          }

          return Container(
            height: MediaQuery.of(context).size.height,
          );
        });
  }
}

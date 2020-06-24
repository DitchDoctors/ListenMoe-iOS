
import 'package:flutter/material.dart';

import '../constants.dart';

class MusicDisc extends StatelessWidget {
  final String _discImage;
  final double value;
  final VoidCallback finishedLoading;
  MusicDisc({Key key,  this.finishedLoading, this.value, @required String discImage}) : _discImage = discImage, super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      

      child: Stack(
        alignment: Alignment.center,
        children: [
        Container(
        alignment: Alignment.center,
        height: 250,
        width: 250,
        child: Image.asset(musicDiscIcon, fit: BoxFit.cover)),
        Center(
        child: SizedBox(
          height: 138,
          width: 138,
          child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(68),
            child: _discImage != null ?
          Image.network(
            _discImage,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, ImageChunkEvent chunk)  {
              if (chunk == null) {
                return child;
              }
              if (chunk.cumulativeBytesLoaded>200) finishedLoading();
              return Image.asset(listenMoeIcon, fit: BoxFit.cover,);
            },  
          ) :
           Image.asset(listenMoeIcon, fit: BoxFit.cover,)
           
           )
           
           ,
        ),
      )
        ],
      )
    );
  }

}
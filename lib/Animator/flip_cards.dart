import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listenmoe/Models/radio_model.dart';
import 'package:listenmoe/Requests/listenMoe+requests.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import '../constants.dart';

class FlipCards extends StatefulWidget {
  final SongInfo songData;
<<<<<<< Updated upstream
  FlipCards({@required this.songData, Key key}) : super(key: key); 
=======
  final Function(String) finishedLoadingImage;

  FlipCards({@required this.songData, this.finishedLoadingImage, Key key}) : super(key: key); 
>>>>>>> Stashed changes

  @override
  _FlipCardsState createState() => _FlipCardsState();
}


class _FlipCardsState extends State<FlipCards> {
  final double fixedSize = 206;
   final _flipper = ValueNotifier<bool>(true);



  final double begin = (200 * pi/180);


  @override
  Widget build(BuildContext context) {



    return ControlledAnimation(
      animationControllerStatusListener: (status) {
        if (status == AnimationStatus.dismissed){
<<<<<<< Updated upstream
          print('home');
          _flipper.value = true;
        }
      
        else if (status == AnimationStatus.completed) {
          print('completed');
=======
          
          _flipper.value = true;
        
        
        }
      
        else if (status == AnimationStatus.completed) {
          
>>>>>>> Stashed changes
         _flipper.value = false;
        }          
      },
      playback: Playback.START_OVER_FORWARD,
      tween: Tween(
        begin: begin,
        end: 0.0,
      ),
      duration: const Duration(milliseconds: (1300)),
      builder: (context, double animation) {
        
        return SizedBox(
          height: fixedSize,
          width: fixedSize,
          child: (widget.songData.d.song.albums?.isEmpty ?? true) ? 
            Transform(
              transform: Matrix4.rotationY(animation),
              origin: Offset((fixedSize*0.5), 0),
              child: Image.asset(listenMoeIcon, fit: BoxFit.cover,),

            )
            : Transform(
              transform: Matrix4.rotationY(0),
              origin: Offset((fixedSize*0.5), 0),
                          child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
<<<<<<< Updated upstream
              color: moeColor,
=======
              color: Colors.transparent,
>>>>>>> Stashed changes
              elevation: 2,
              child: ((widget.songData.d.song.albums?.isNotEmpty ?? false) &&
                      widget.songData.d.song.albums?.first?.image != null)
                  ? Transform(
                    transform: Matrix4.rotationY(animation),
                    origin: Offset((fixedSize*0.5), 0),
                                      child: Image.network(
<<<<<<< Updated upstream
                      'https://cdn.listen.moe/covers/${widget.songData.d.song.albums.first.image}',
=======
                      listenMoeCover + widget.songData.d.song.albums.first.image,
                      
>>>>>>> Stashed changes
                       headers: ListenMoeRequests.headers,
                       
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, percentage) {
                          if (percentage == null ) {                            
                            return ValueListenableBuilder<bool>(
                              valueListenable: _flipper,
                              builder: (context, value, _) {
<<<<<<< Updated upstream
=======
                                
>>>>>>> Stashed changes
                                return (animation <= 1.5) ?  child : Image.asset(
                                      listenMoeIcon,
                                      fit: BoxFit.cover,
                                    );
                              },
                            );

                          } else {
<<<<<<< Updated upstream
=======
                          
>>>>>>> Stashed changes
                          return Stack(
                                                      children: <Widget>[
                                        Image.asset(
                                          listenMoeIcon,
                                          fit: BoxFit.cover,
                                        ),
                                        Center(
                                          child: CircularProgressIndicator(
                                            value: percentage.expectedTotalBytes != null ? percentage.cumulativeBytesLoaded / percentage.expectedTotalBytes : 
                                            Image.asset(
                                      listenMoeIcon,
                                       fit: BoxFit.cover,
                                     ),
                                          ),
                                        )
                                      ],
                          );
                          }
                          // else {
                          //   setState(() => _isFront = true);
                          // return _isFront ? Center(
                          //   child: CircularProgressIndicator(
                          //     value: percentage.expectedTotalBytes != null
                          //         ? percentage.cumulativeBytesLoaded /
                          //             percentage.expectedTotalBytes
                          //         : Image.asset(
                          //             listenMoeIcon,
                          //             fit: BoxFit.cover,
                          //           ),
                          //   ),
                          // );
                          // }
                        },
                      ),
                  )
                  : Image.asset(
                      listenMoeIcon,
                      fit: BoxFit.cover,
                    ),
          ),
            ),
        );
      },
    );
  }
}

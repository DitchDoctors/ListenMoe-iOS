import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';

class BackgroundSplash extends StatefulWidget {
  final String url;
  BackgroundSplash({Key key, @required url}) : this.url = url, super(key:key);
  @override
  State<StatefulWidget> createState() => _BackgroundSplash();

}

class _BackgroundSplash extends State<BackgroundSplash> with SingleTickerProviderStateMixin {
   
  Animation<double> opactiy;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    opactiy = Tween(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
      ));
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
        widget.url != null? Image.network(
                widget.url,
                fit: BoxFit.cover,
               loadingBuilder: (context, child, ImageChunkEvent chunk)  {
              if (chunk == null) {
                return child;
              }
              if (chunk.cumulativeBytesLoaded>200) {
               
                _controller.fling();
                
              }
              return Container();
            }, 
              ) : Container(),
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
                  )
                )
              ),
       AnimatedBuilder(
         animation: _controller,
         builder: (context, child) {
           return Container(
             child: child,
            );
         },
        child: Container(
          
          decoration: BoxDecoration(color: 
             moeColor.withOpacity(0)
          ),
          
        ),
       )
      ],),
    );
  }

}
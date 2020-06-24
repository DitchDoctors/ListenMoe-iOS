
import 'package:flutter/material.dart';
import 'package:listenmoe/Components/musicCard.dart';
import 'package:listenmoe/Components/musicDisc.dart';
import 'dart:math' as math;

import 'package:listenmoe/Components/rotation.dart';

class MusicDiscContainer extends StatefulWidget {
  final String url;
  MusicDiscContainer({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicDiscContainer();
}

class _MusicDiscContainer extends State<MusicDiscContainer> with TickerProviderStateMixin {
  AnimationController reader;
  AnimationController controller;
  AnimationController card;


  Animation<double> thrower;
  Animation<double> rotation;
  Animation<double> flipper;
  Animation<double> back;

  bool showingCover = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  _setup() {
    card = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    reader = AnimationController(vsync: this, duration: Duration(minutes: 1));
    controller = AnimationController(vsync: this, duration: Duration(milliseconds:2000));
    thrower = Tween<double>(begin: -275, end: 0)
    .animate(
      CurvedAnimation(
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
        parent: controller,
      )
    );
    flipper = Tween<double>(begin: 180, end: 0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 1, curve: Curves.linear)
        )
      );
     rotation = Tween(begin: 0.0, end: 1.0)
         .animate(reader);

      back = Tween(begin: 0.0, end: 180.0)
        .animate(card);
  }

  

  _throwInAnimation() {
    controller.forward().whenComplete(() => this._playAnimation());
  }
  
  _playAnimation() =>
  reader.repeat();

  _flipCover() {
    card.forward();
  }

  Widget _fade() {
    return AnimatedCrossFade(
      firstChild: RotationTransition(
        turns: rotation,
        child: MusicDisc(
        discImage: widget.url,
        finishedLoading: () => this._throwInAnimation(),
        ),  
      ), 
      secondChild: Center(child: MusicCard(url: widget.url)), 
      crossFadeState: (!showingCover) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          transform: Matrix4.identity()
          ..rotateX(flipper.value*math.pi/180),
                  child: Container(
            transform: Matrix4.translationValues(0.0, thrower.value, 0.0),
            child: child,  
          ),
        );
      },
      child: GestureDetector(
        onTap: () => this.setState(() => showingCover = !showingCover),
        child: _fade()
      )
    );
    // return Container(
    //   child: RotationTransition(
    //     turns: Tween(begin: 0.0, end: 1.0)
    //     .animate(controller),
    //     child: MusicDisc(
    //     discImage: widget.url,
    //     finishedLoading: () => {
    //       this._playAnimation()
    //     },
    //   ), 
    //   )
      
    // );
    
  }

}



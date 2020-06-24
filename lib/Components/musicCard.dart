import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  final String url;
  MusicCard({Key key, @required url }) : this.url = url, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
          child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Image.network(
          url,
          height: 285,
          width: 285,
        ),
      ),
    );
  }

}
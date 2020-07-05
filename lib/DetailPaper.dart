import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplashtest/PaperList.dart';

// ignore: must_be_immutable
class DetailPaper extends StatelessWidget{

  String url;
  DetailPaper({this.url});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DetailPaper', style: TextStyle(fontFamily: 'Pacifico'),),
        ),
        body: Center(
          child: Image(
            image: NetworkImage(url),
          ),
        ),
        ),
      );
  }
}
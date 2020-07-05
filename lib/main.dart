

import 'package:flutter/material.dart';
import 'package:unsplashtest/DetailPaper.dart';
import 'package:unsplashtest/PaperList.dart';

void main() {
  runApp( MaterialApp(
    //initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/':(BuildContext context) => PapersList(),
      '/dp':(BuildContext context) => DetailsPaper(),
    },
  ),);

}

class PapersList extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: PaperList(),
    );
  }
}
class DetailsPaper extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DetailPaper(),
    );
  }
}
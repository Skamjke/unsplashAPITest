import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unsplashtest/DetailPaper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:unsplashtest/main.dart';

class PaperList extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return PaperListState();
  }
}

class PaperListState extends State<PaperList>{
  List data;
  String urlReg;
  String _search = 'london';
  Icon searchIcon = Icon(Icons.search);
  Icon refreshIcon = Icon(Icons.refresh);
  Widget searchText = Text('Awesome Paper', style: TextStyle(fontFamily: 'Pacifico'),);
  @override
  void initState(){
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: searchText,
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  setState(() {
                    if (this.searchIcon.icon == Icons.search){
                      this.searchIcon = Icon(Icons.cancel);
                      this.searchText=TextField(
                        autofocus: true,
                        onChanged: (text){
                          setState(() {
                            _search = text;
                            _loadData();
                          });
                          },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText:'Search Wallpaper',
                          hintStyle: TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      );
                    }
                    else{
                      this.searchIcon = Icon(Icons.search);
                      this.searchText = Text('Awesome Paper',style: TextStyle(fontFamily: 'Pacifico'),);
                    }
                  });
                  },
                icon: searchIcon,
              )
            ],
          ),
          body: Container(
            child: new ListView.builder(
                itemCount: data == null?0:data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildList(context,index),
                      ),
                    ),
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
            child: refreshIcon,
            onPressed: (){
              setState(() {
                _loadData();
              });
            },
          ),
        )
    );
  }

_loadData () async{
    try{
      final response = await http.get('https://api.unsplash.com/photos/random?count=30&query=${_search}&client_id=BXgkn90H5nntHy1-1zL5vxuHBynNkWmSRNpALG7UvQY');
      setState(() {
        if(response.statusCode == 200){
          var allData = json.decode(response.body);
          data = allData;
        }
      });
    }catch(e){
      return 'success';
    }
}



_buildList(BuildContext context, int index){
    List<Widget> widgets = [];
    String desc = data[index]['description'];
    if (desc == null)
    {
      desc = 'undefiend';
    }
    widgets.add(GestureDetector(
        child: new Card(
          child: new Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(data[index]['urls']['small'],
                  width: MediaQuery.of(context).size.width,),
                  new Text('Author: '+data[index]['user']['username'], style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Pacifico',
                      color: new Color(0xFF26C6DA),)),
                  new Text('Description: '+desc, style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Pacifico',
                    color: new Color(0xFF26C6DA),)),
                ],)
          ),
        ),
      onTap: (){
          urlReg = data[index]['urls']['regular'];
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPaper(url: urlReg,)));
      },
    )
    );

    return widgets;
}
}
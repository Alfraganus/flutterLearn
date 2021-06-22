import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) :super (key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;
  List data;

  Future<dynamic> getData() async {

    Map params =  {
      'user_id':23
    };
    var response = await http.post(
        Uri.http('api.spector77.uz', 'rest/sales/finished-sales'), body: params
    );

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data);
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      title: Text('Spector'),
    ),
    body: new ListView.builder(
      itemCount:  10,
      itemBuilder: (BuildContext context, dynamic index){
    if (data != null && data.length > 0) {
      return new Card(
        child: new Text(data[index]["id"]),
      );
    } else {
     return  new Text('malumot topilmadi');
    }
      },
    ),
    drawer: Drawer(
      child: ListView(

      ),
    ),
  );

  }
}





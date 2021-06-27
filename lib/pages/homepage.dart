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
  Future<List<Sales>> futureAlbum;
  @protected
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Spector'),
      ),
      body: Center(
        child: FutureBuilder<List<Sales>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [

                        Text(
                            "id = ${snapshot.data[index].Id}"
                        ),

                        Text(
                            " time = ${snapshot.data[index].time}"
                        ),
                      ],
                    );
                  }
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(

        ),
      ),
    );

  }
}

class Sales {
  final String Id;
  final String time;

  Sales({this.Id, this.time});

  factory Sales.fromJson({Map<String, dynamic> json}) {
    return Sales(
        Id: json['id'].toString(),
        time:json['time'].toString()
    );
  }

  static List<Sales> fetchData({List jsonList}) {
    List<Sales> list = [];

    for (int i = 0; i < jsonList.length; i++) {
      list.add(Sales.fromJson(json: jsonList[i]));
    }

    return list;
  }
}


Future<List<Sales>> fetchAlbum() async {
  try {
    final http.Response response = await http.get(
        Uri.parse('https://api.spector77.uz/rest/sales/finished-sales')
    );

    if (response.statusCode == 200) {
      return Sales.fetchData(jsonList: jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load sales');
    }
  }catch(e) {
    print(e);
  }
}
// Developer Tolkinov Muhammed
// Email: tolkinov1999@gmail.com
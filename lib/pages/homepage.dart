import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/saleModel.dart';
import 'package:http/http.dart' as http;


Future<List<Sales>> fetchAlbum() async {
  try {
    final http.Response response = await http.get(
        Uri.parse('https://api.spector77.uz/rest/sales/finished-sales?expand=productCategory')
    );

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
          return Sales.fetchData(jsonList: jsonDecode(response.body));
    }

    else {
      throw Exception('Failed to load sales');
    }

  }catch(e) {
    print(e);
  }
}


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

      body: Center(
        child: FutureBuilder<List<Sales>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  // physics: Scrollable.of(context),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                            child: ListTile(
                                title: Text(snapshot.data[index].name),
                              subtitle:Text(snapshot.data[index].time),
                              trailing:Text(snapshot.data[index].Id),
                            )
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

    );

  }
}




// Developer Tolkinov Muhammed
// Email: tolkinov1999@gmail.com
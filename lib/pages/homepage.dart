import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/saleModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'finishedSale.dart';
import 'sale_form.dart';

Future<List<Sales>> fetchAlbum() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.get(
        Uri.parse('https://api.spector77.uz/rest/sales/finished-sales?expand=productCategory&user_id=${prefs.getString('token')}')
    );
    if (response.statusCode == 200) {
      // print('the body is '+(response.body));
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
              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: fetchAlbum,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          // physics: Scrollable.of(context),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                    child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FinishedSale(id:snapshot.data[index].Id,sum:snapshot.data[index].overall_sale ,)),
                                    );
                                  },
                                     leading:Image.network('https://thumbs.dreamstime.com/b/medal-green-icon-approved-certified-isolated-white-background-flat-design-vector-illustration-148951474.jpg'),
                                      title: Text(snapshot.data[index].name),
                                      subtitle:Text(snapshot.data[index].time.toString()),
                                      trailing:Text(snapshot.data[index].overall_sale.toString()+' so\'m'),
                                    )
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                ],
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductForm()),
          );
        },
        label: const Text('Yangi savdo qilish'),
        icon: const Icon(Icons.add_circle),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

      ),
    );
  }
}







// Developer Tolkinov Muhammed
// Email: tolkinov1999@gmail.com
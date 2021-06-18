import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alfraganus Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class User {
  final String name, username,email;
  User(this.name, this.username, this.email);
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future getData()  async {
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for(var u in jsonData) {
      User user = User(u['name'],u['username'],u['email']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getData(),
            builder: (context,snapshot) {
              if(snapshot.data == null) {
                return Container(
                  child:  Center(
                    child: Text('Loading'),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].username),
                        trailing: Text(snapshot.data[i].email),
                      );
                  },
                );
              }
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

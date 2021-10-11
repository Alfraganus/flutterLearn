import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:file/local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  // Note that this line is required, otherwise flutter throws an error
  // about using binary messenger before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  runApp(new MyApp(sharedPref));
}


class MyApp extends StatelessWidget {
  final SharedPreferences sharedPref;
  MyApp(this.sharedPref);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spector light",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
          accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  set token(String token) {
    this.token = token;
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    } else {
      token =  sharedPreferences.getString("token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spector light", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: MyHomePage(),
      drawer: Drawer(),
    );
  }
}


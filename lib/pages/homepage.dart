import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) :super (key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    drawer: Drawer(
      child: ListView(

      ),
    ),
  );

  }
}

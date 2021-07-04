import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinishedSale extends StatelessWidget {
  final int id;

  const FinishedSale({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${id}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/saleSingle.dart';


class FinishedSale extends StatefulWidget {
  @override
  _FinishedSaleState createState() => _FinishedSaleState();
  final int id;
  const FinishedSale({Key key, this.id}) : super(key: key);

}

class _FinishedSaleState extends State<FinishedSale> {
  Future<List<SingleSale>> futureAlbum;
  @protected
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('test'),
        ),
      ),
    );
  }
}





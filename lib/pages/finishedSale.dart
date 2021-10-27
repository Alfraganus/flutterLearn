import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/singleSale.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<List<SingleSale>> fetchAlbums(String url) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(url)
    );
    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return SingleSale.fetchData(jsonList: jsonDecode(response.body)['sales']);
    }
    else {
      throw Exception('Failed to load sales');
    }

  }catch(e) {
    print(e);
  }
}



class FinishedSale extends StatefulWidget {
  @override
  _FinishedSaleState createState() => _FinishedSaleState();
  final int id;
  final String sum;
  const FinishedSale({Key key, this.id,this.sum}) : super(key: key);

}

class _FinishedSaleState extends State<FinishedSale> {
  Future<List<SingleSale>> futureAlbum;

  @protected
  void initState() {
    futureAlbum = fetchAlbums('https://api.spector77.uz/rest/sales/single-sale?expand=productCategory&sale_id=${widget.id}');
    print(futureAlbum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Sotilgan maxsulotlar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: FutureBuilder<List<SingleSale>>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        // physics: Scrollable.of(context),
                        shrinkWrap:true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading:Image.network('https://thumbs.dreamstime.com/b/medal-green-icon-approved-certified-isolated-white-background-flat-design-vector-illustration-148951474.jpg'),
                                  title: Text(snapshot.data[index].name),
                                  trailing:Text(snapshot.data[index].price.toString()+' so\'m'),
                                  subtitle:Text(snapshot.data[index].quantity.toString()+' dona'),
                                ),
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
            TitleWithMoreBtn(title: "Umumiy savdo summasi: ",value:widget.sum, press: () {}),
          ],
        ),
      )

    );

  }
}




class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.value,
    this.press,
  }) : super(key: key);
  final String title;
  final String value;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Color(0xFF0C9869),
            onPressed: press,
            child: Text(
              value+' so\'m',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:  20.0 / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right:  20.0 / 4),
              height: 7,
              color: Color(0xFF0C9869).withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}





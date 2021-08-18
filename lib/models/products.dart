import 'package:http/http.dart' as http;
import 'dart:convert';


class Products {
  final int id;
  final String name;

  Products({this.id,this.name});

  factory Products.fromJson({Map<dynamic, dynamic> json}) {
    return Products(
        id:json['id'],
        name:['name'].toString(),
    );
  }
  static List<Products> fetchData({List jsonList}) {
    List<Products> list = [];

    for (int i = 0; i < jsonList.length; i++) {
      list.add(Products.fromJson(json: jsonList[i]));
    }
    return list;
  }

}

Future<List<Products>> getProducts() async {
  try {
    final http.Response response = await http.get(
        Uri.parse('https://api.spector77.uz/rest/sales/products')
    );
    if (response.statusCode == 200) {
      // print('the body is '+(response.body));
      return Products.fetchData(jsonList: jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load sales');
    }

  }catch(e) {
    print(e);
  }
}



/*getting prices and leftovers*/

class Stock {
  final String quantity;
  final String price;

  Stock({this.quantity,this.price});

  factory Stock.fromJson({Map<dynamic, dynamic> json}) {
    return Stock(
      quantity:json['quantity'],
      price:['price'].toString(),
    );
  }

  static List<Products> fetchData({List jsonList}) {
    List<Products> list = [];
    for (int i = 0; i < jsonList.length; i++) {
      list.add(Products.fromJson(json: jsonList[i]));
    }
    return list;
  }

}


Future<List<Products>> getStock(url) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(url)
    );
    if (response.statusCode == 200) {
      // print('the body is '+(response.body));
      return Stock.fetchData(jsonList: jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load sales');
    }

  }catch(e) {
    print(e);
  }
}

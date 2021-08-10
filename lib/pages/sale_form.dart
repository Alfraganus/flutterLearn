import 'dart:convert';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/singleSale.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';



Future<List<Products>> getProducts() async {
  try {
    final http.Response response = await http.get(
        Uri.parse('https://api.spector77.uz/rest/sales/products}')
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


class SaleForm extends StatefulWidget {
  @override
  _SaleFormState createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  Future<List<Products>> products;

  @protected
  void initState() {
    super.initState();
    products = getProducts();
    // user_id = _loadCounter().toString();
    // print('user_id: '+user_id);
  }

  String country_id='';
  List<String> country = [
    "America",
    "Brazil",
    "Canada",
    "India",
    "Mongalia",
    "USA",
    "China",
    "Russia",
    "Germany"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sotilgan maxsulotlar: '+country_id),
        ),
        body:Column(
          children: [
            Text('dropdown uchun'+country_id),
            DropDownField(
              onValueChanged: (value) {
                setState(() {
                  country_id = value;
                });
              },
              value: country_id,
              required: false,
              hintText: 'Choose a country',
              labelText: 'Country',
              items: country,
            ),
          ],
        )

    );
  }
}






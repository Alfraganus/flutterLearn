import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/userApi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';


dynamic product = 'Search product';
String product_id = '';
String quantity = '';
String price = '';
dynamic test = '';

class ProductForm extends StatefulWidget {

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  static readPrefStr(dynamic key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print( pref.getString(key));
  }

  @override
  void initState() {
    readPrefStr('token');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product page'),
      ),
      body:
      Column(
        children: [
          Padding(padding:  EdgeInsets.all(16)),
          Text('Productid :'+product_id),
          Text('quantity :'+quantity),
          Text('price :'+price),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TypeAheadField<User>(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: product,
                  ),
                ),
                suggestionsCallback: UserApi.getUserSuggestions,
                itemBuilder: (context, User suggestion) {
                  final user = suggestion;

                  return ListTile(
                    title: Text(user.name),
                  );
                },
                noItemsFoundBuilder: (context) => Container(
                  height: 100,
                  child: Center(
                    child: Text(
                      'No Users Found.',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                onSuggestionSelected: (User suggestion) {
                  final user = suggestion;
                  // getStock('sql query api');
                  setState(() {
                    product = '${user.name}';
                    product_id = '${user.id}';
                  });
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Selected product: ${user.name}'),
                    ));
                },
              ),
            ),
          ),
      SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(),
                hintText: 'Enter quantity'
            ),
            onChanged: (text) {
              quantity = text;
            },
          ),
        ),
      ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(),
                    hintText: 'Enter price'
                ),
                onChanged: (text) {
                  price = text;
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Send'),
          )
        ],
      ),

    );
  }
}





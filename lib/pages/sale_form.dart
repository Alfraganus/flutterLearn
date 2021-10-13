import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/userApi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';


dynamic product = 'Search product';
String product_id = '';

dynamic test = '';

final List<String> products = <String>[];
final List<String> quantity = <String>[];
final List<String> price = <String>[];
final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void addItemToList(){
    setState(() {
      products.insert(0,product);
      price.insert(0,priceController.text);
      quantity.insert(0,quantityController.text);
      msgCount.insert(0, 0);
    });
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

          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TypeAheadField<User>(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: productController,
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
            controller: quantityController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(),
                hintText: 'Enter quantity'
            ),
          ),
        ),
      ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(),
                    hintText: 'Enter price'
                ),

              ),
            ),
          ),
          TextButton(
            onPressed: () {
              addItemToList();
            },
            child: Text('Send'),
          ),
          Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    color: msgCount[index]>=10? Colors.blue[400]:
                    msgCount[index]>3? Colors.blue[100]: Colors.grey,
                    child: Center(
                        child: Text('product:' +'${products[index]} price: (${price[index]}) quantity: (${quantity[index]})',
                          style: TextStyle(fontSize: 18),
                        )
                    ),
                  );
                }
            ),
          )
        ],
      ),


    );
  }
}



//list qilib localda saqlab olish kerak, kegin jonatiladi

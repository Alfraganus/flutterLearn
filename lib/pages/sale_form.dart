import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Product.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/userApi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

dynamic product = 'Search product';
String product_id = '';

dynamic test = '';
List<Product> newproducts = [];

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
      newproducts.add(Product(
        product_name:product,
        quantity:quantityController.text,
        price:priceController.text,
      )
      );
    });
  }

 void sendProducts() async {
    String products = jsonEncode(newproducts);
  await http.post(Uri.http('api.spector77.uz','rest/sales/test'), body: newproducts);
     print(jsonEncode(newproducts));

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
            child:SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: newproducts.map((personone){
                    return Container(
                      child: Card(
                        child:ListTile(
                          title: Text(personone.product_name),
                          subtitle: Text(personone.price + "\n" + personone.quantity),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent
                            ),
                            child: Icon(Icons.delete),
                            onPressed: (){
                              //delete action for this button
                              newproducts.removeWhere((element){
                                return element.product_name == personone.product_name;
                              }); //go through the loop and match content to delete from list
                              setState(() {
                                product = '';
                                priceController.text = '';
                                quantityController.text = '';
                                //refresh UI after deleting element from list
                              });
                            },
                          ),
                        ),
                      ),

                    );
                  }).toList(),
                ),
              ),
            ) ,
          ),
          TextButton(
            onPressed: () {
              sendProducts();
            },
            child: Text('Send to API'),
          ),
        ],
      ),


    );
  }
}



//list qilib localda saqlab olish kerak, kegin jonatiladi

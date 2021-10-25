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
import 'package:connectivity/connectivity.dart';

import 'homepage.dart';

dynamic product = 'Search a product';
String product_id = '';
String product_name = '';
dynamic test = '';
List<Product> newproducts = [];
String sharedPrefs;
String product_price = '';
String leftquantity = '';

void emptyDatas()
{
  product = 'Search a product';
  newproducts =[];
}



class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs.get('token'));
    });
  }


  void addItemToList() {
    setState(() {
      newproducts.add(Product(
          product_name: product_name,
          product_id: product_id,
          quantity: quantityController.text,
          price: priceController.text,
          user_id: sharedPrefs));
    });
  }

 void sendProducts() async {

 var response = await http.post(Uri.http('api.spector77.uz','rest/sales/test'), body: json.encoder.convert(newproducts));
   // print(json.encoder.convert(newproducts));
   print(newproducts);

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
      Text('Pruduct price: '+product_price+' so\'m'),
      Text('Product quantity left: '+leftquantity),
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
                    product_name = product = '${user.name}';
                    product_id = '${user.id}';
                    product_price = '${user.price}';
                    leftquantity ='${user.leftquantity}';
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
             if(product_id !='' || quantityController.text != '' || priceController.text != '') {
               addItemToList();
               product_id='';
               product = 'Search a product';
               quantityController.text='';
               priceController.text='';
             } else {
               showDialog(
                 context: context,
                 builder: (BuildContext context) {
                   return   _showDialog('Xatolik bor!','Barcha maydonlar toldirilishi shart!');
                 },
               );

            }
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
          newproducts.length>0? TextButton(
            onPressed: () {
              sendProducts();
              emptyDatas();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: Text('Send to API'),
          ) :Text('')
        ],
      ),
    );
  }

  _showDialog(title,text) {
    showDialog(
      context: context,
      builder: (context) {
        return   AlertDialog(
          title: Text(title),
          content: Text(text),
        );;
      },
    );
  }

  _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none) {
      _showDialog('Xatolik bor!','Internet mavjud emas!');
    } else if(result == ConnectivityResult.wifi) {
      _showDialog('Xatolik yoq!','Internet wifi!');
    }
    else if(result == ConnectivityResult.mobile) {
      _showDialog('Xatolik yoq!','Internet mobilniki!');
    }
  }


}







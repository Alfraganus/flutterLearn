import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Product.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/userApi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'finishedSale.dart';
import 'homepage.dart';

dynamic product = 'Search a product';
String product_id = '';
String product_name = 'Maxsulot nomlari';
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
 await http.post(Uri.http('api.spector77.uz','rest/sales/test'), body: json.encoder.convert(newproducts));
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
          TitleWithMoreBtn(title: "Maxsulot narxi: ",value: product_price, press: () {}),
          Padding(padding:  EdgeInsets.only(top: 15)),
          TitleWithMoreBtn(title: "Qoldiq: ",value: leftquantity, press: () {}),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TypeAheadField<User>(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: productController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.list),
                    labelText:product_name??'Maxsulot tanlang!',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
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
                      'Maxsulot tanlanilmadi!',
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
                    product_price = '${user.price} so\'m';
                    leftquantity ='${user.leftquantity} dona';
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
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              icon: Icon(Icons.assignment),
              labelText: 'Sotilayotgan miqdor',
              labelStyle: TextStyle(
                color: Color(0xFF6200EE),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)),
              ),
            ),
          ),
        ),
      ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'Sotilayotgan Narx',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),

              ),
            ),
          ),

          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () async {
                var internet = await Connectivity().checkConnectivity();
                  if(internet==ConnectivityResult.none || internet=='ConnectivityResult.none') {
                    _showDialog('Xatolik bor','Internet mavjud emas!');
                  } else {
                    if(product_id =='' || quantityController.text ==''  || priceController.text =='' ) {
                      return   _showDialog('Xatolik bor!','Barcha maydonlar toldirilishi shart!');
                    } else {
                      addItemToList();
                      product_id='';
                      product_name ='Maxsulot nomlari';
                      quantityController.text='';
                      priceController.text='';
                      product_price='';
                      leftquantity ='';
                    }
                  }

              },
            ),
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
                          title: Text("Nomi: "+personone.product_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          subtitle: Text("Narxi: "+personone.price + "so\'m \n" +
                              "Sanog\'i: "+personone.quantity+" dona",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)
                          ),
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
          newproducts.length > 0 ? ElevatedButton.icon(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 34.0,
            ),
            label: Text('Savdoni amalga oshirish'),
            onPressed: () async {
              var internet = await Connectivity().checkConnectivity();
              if(internet==ConnectivityResult.none || internet=='ConnectivityResult.none') {
                _showDialog('Xatolik bor','Internet mavjud emas!');
              }  else {
                sendProducts();
                emptyDatas();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
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
      test = 'internet yooq';
    }  else {
      test = 'internet boooor';
    }

  }


}







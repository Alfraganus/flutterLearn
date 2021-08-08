import 'package:http/http.dart' as http;
import 'dart:convert';


class SingleSale {
  String name;
  String quantity;
  String price;

  SingleSale({this.name, this.quantity,this.price});
}

Future<void> getNews() async{
  List<SingleSale> sale  = [];
  final http.Response response = await http.get(Uri.http('api.spector77.uz', 'rest/sales/single-sale?sale_id=1625406037&expand=productCategory'));
  var jsonData = jsonDecode(response.body);

  if(response.statusCode==200) {
    jsonData.forEach((element) {
      SingleSale single = SingleSale(
        name: element['productCategory']['name'],
        quantity: element['quantity'],
        price: element['price_id'],
      );
      sale.add(single);
    });
  }
}



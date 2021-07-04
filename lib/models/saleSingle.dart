import 'package:http/http.dart' as http;
import 'dart:convert';


class SingleSale {
  List<SingleSale> sale  = [];

  Future<void> getNews() async{
    String url = "abs";

    var response = await http.get(url);
  }
}
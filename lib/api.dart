import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' show jsonDecode, jsonEncode;

class test {
  Future<http.Response> createAlbum(String title) {
    return http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }
}

Future<dynamic> getData()  async {
  var response = await http.post(Uri.http('scandiweb.veral.uz','site/login'),body: {
    'username':'admin',
    'password':'admin253'
  });
  var jsonData = jsonDecode(response.body);

  print(jsonData);
}

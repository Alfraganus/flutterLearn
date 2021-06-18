import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' show jsonEncode;

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
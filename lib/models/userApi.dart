import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String id;
  final String price;
  final String leftquantity;

  const User({
    this.name,
    this.id,
    this.price,
    this.leftquantity
  });

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    id: json['id'].toString(),
    price: json['product_price'].toString(),
    leftquantity: json['product_quantity'].toString(),
  );

}

class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    final url = Uri.parse('https://api.spector77.uz/rest/sales/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else  {
      throw Exception();
    }
  }
}
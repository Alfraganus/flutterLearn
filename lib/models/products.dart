class Products {
  final int id;
  final String name;

  Products({this.id,this.name});

  factory Products.fromJson({Map<dynamic, dynamic> json}) {
    return Products(
        id:json['id'],
        name:['name'].toString(),
    );
  }

  static List<Products> fetchData({List jsonList}) {
    List<Products> list = [];

    for (int i = 0; i < jsonList.length; i++) {
      list.add(Products.fromJson(json: jsonList[i]));
    }

    return list;
  }

}
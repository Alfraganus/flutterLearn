class SingleSale {
  final String name;
  final String price;
  final int quantity;
  final String priceForEach;

  SingleSale({this.name, this.price,this.quantity,this.priceForEach});

  factory SingleSale.fromJson({Map<dynamic, dynamic> json}) {
    return SingleSale(
        name:json['productCategory']['name'].toString(),
        price:json['current_sale_sum'].toString(),
        priceForEach:json['price_id'].toString(),
        quantity:json['quantity']
    );
  }

  static List<SingleSale> fetchData({List jsonList}) {
    List<SingleSale> list = [];

    for (int i = 0; i < jsonList.length; i++) {
      list.add(SingleSale.fromJson(json: jsonList[i]));
    }

    return list;
  }

}
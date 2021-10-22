class Product {
      String product_name, quantity, price,user_id;
      Product({this.product_name, this.quantity, this.price,this.productList,this.user_id});

      List<Product> productList;

      @override
      toString() {
            return "product_name: " + product_name + ", quantity: " + quantity+ ", price: " + price;
      }

     Map<String, dynamic> toJson() {
            return {
              'product_name': product_name,
              'quantity': quantity,
              'price': price,
              'user_id': user_id,
            };
      }

}
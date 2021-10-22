class Product {
      String product_name,product_id, quantity, price,user_id;
      Product({this.product_name,this.product_id, this.quantity, this.price,this.productList,this.user_id});

      List<Product> productList;

      @override
      toString() {
            return "product_name: " + product_name + ", quantity: " + quantity+ ", price: " + price;
      }

      @override
     Map<String, dynamic> toJson() {
            return {
              'product_name': product_name,
              'product_id': product_id,
              'quantity': quantity,
              'price': price,
              'user_id': user_id,
            };
      }

}
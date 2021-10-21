class Product {
      String product_name, quantity, price;
      Product({this.product_name, this.quantity, this.price,this.productList});

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
            };
      }

}
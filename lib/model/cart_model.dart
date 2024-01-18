class CartModel {
  final int id;
  final String name;
  final int initial_price;
  final int products_price;
  final String image;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.initial_price,
    required this.products_price,
    required this.image,
    required this.quantity
  });

  CartModel.fromMap(Map<dynamic, dynamic> resource)
      : id = resource['id'],
        name = resource['name'],
        initial_price = resource['initial_price'],
        products_price = resource['products_price'],
        image = resource['image'],
        quantity = resource['quantity'];

  Map<String,dynamic> toMap(){

    return {
      'id' : id,
      'name' : name,
      'initial_price' : initial_price,
      'products_price' : products_price,
      'image' : image,
      'quantity' : quantity,

    };

  }


}
class CartItem {
  final int productId;
  final int quantity;

  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class Cart {
  final int id;
  final int userId;
  final List<CartItem> items;

  Cart({required this.id, required this.userId, required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List)
        .map((p) => CartItem.fromJson(p))
        .toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      items: products,
    );
  }
}

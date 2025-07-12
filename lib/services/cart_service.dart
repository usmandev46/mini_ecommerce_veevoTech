import 'package:dio/dio.dart';

import '../models/cart/cart_model.dart';

class CartService {
  final Dio dio = Dio();

  Future<Cart> getCart(int userId) async {
    final response = await dio.get("https://fakestoreapi.com/carts/user/$userId");
    final carts = response.data as List;
    if (carts.isNotEmpty) {
      return Cart.fromJson(carts.last);
    } else {
      throw Exception("No cart found.");
    }
  }

  Future<Cart> updateCart(Cart cart) async {
    final response = await dio.put(
      'https://fakestoreapi.com/carts/${cart.id}',
      data: {
        'userId': cart.userId,
        'products': cart.items.map((item) => {
          'productId': item.productId,
          'quantity': item.quantity,
        }).toList(),
      },
    );
    return Cart.fromJson(response.data);
  }

}

import '../../models/cart/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

// New states for quantity updates
class CartUpdatingQuantity extends CartState {
  final Cart cart;
  CartUpdatingQuantity(this.cart);
}

class CartQuantityUpdateError extends CartState {
  final String message;
  final Cart? cart;
  CartQuantityUpdateError(this.message, [this.cart]);
}

class CartLoaded extends CartState {
  final Cart cart;
  CartLoaded(this.cart);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

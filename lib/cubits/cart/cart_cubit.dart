import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart/cart_model.dart';
import '../../services/cart_service.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;
  CartCubit(this.cartService) : super(CartInitial());

  Cart? _currentCart;

  Future<void> fetchCart(int userId) async {
    try {
      emit(CartLoading());
      final cart = await cartService.getCart(userId);
      _currentCart = cart;
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> increaseQuantity(int productId) async {
    if (_currentCart == null) return;
    final items = List<CartItem>.from(_currentCart!.items);

    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      final item = items[index];
      items[index] = CartItem(
        productId: item.productId,
        quantity: item.quantity + 1,
      );
      await _updateCart(items);
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    if (_currentCart == null) return;
    final items = List<CartItem>.from(_currentCart!.items);

    final index = items.indexWhere((item) => item.productId == productId);
    if (index != -1 && items[index].quantity > 1) {
      final item = items[index];
      items[index] = CartItem(
        productId: item.productId,
        quantity: item.quantity - 1,
      );
      await _updateCart(items);
    }
  }

  Future<void> removeItem(int productId) async {
    if (_currentCart == null) return;
    final items = List<CartItem>.from(_currentCart!.items);
    items.removeWhere((item) => item.productId == productId);

    await _updateCart(items);
  }

  Future<void> _updateCart(List<CartItem> updatedItems) async {
    try {
      emit(CartLoading());

      final updatedCart = Cart(
        id: _currentCart!.id,
        userId: _currentCart!.userId,
        items: updatedItems,
      );

      final cart = await cartService.updateCart(updatedCart);
      _currentCart = cart;
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cart/cart_cubit.dart';
import '../../cubits/cart/cart_state.dart';
import '../../services/cart_service.dart';
import '../../widgets/custom_loader.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(CartService())..fetchCart(1),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Cart'),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: PouringHourGlassRefined());
            } else if (state is CartLoaded) {
              if (state.cart.items.isEmpty) {
                return const Center(child: Text("Cart is empty."));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.cart.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = state.cart.items[index];

                  return  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[850]
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_cart_rounded,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product ID: ${item.productId}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  // Decrease Quantity Button
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      context.read<CartCubit>().decreaseQuantity(item.productId);
                                    },
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  // Increase Quantity Button
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      context.read<CartCubit>().increaseQuantity(item.productId);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Remove Button
                        IconButton(
                          icon:  Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
                          onPressed: () {
                            context.read<CartCubit>().removeItem(item.productId);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(
                child: Text(" ${state.message}"),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

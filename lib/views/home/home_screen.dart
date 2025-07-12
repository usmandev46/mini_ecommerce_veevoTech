import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../cubits/product/product_cubit.dart';
import '../../cubits/product/product_state.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/productCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(Dio())..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Products'),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: PouringHourGlassRefined());
            } else if (state is ProductLoaded) {
              final products = state.products;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductCubit>().fetchProducts();
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            } else if (state is ProductEmpty) {
              return const Center(child: Text('No products found'));
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}


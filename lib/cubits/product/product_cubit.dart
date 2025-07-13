import 'package:dio/dio.dart';
import 'package:ecommerce_app_veevo_tech/cubits/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product/product.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio;
  List<Product> _allProducts = [];

  ProductCubit(this.dio) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await dio.get('https://fakestoreapi.com/products');
      final data = response.data as List;
      final products = data.map((json) => Product.fromJson(json)).toList();
      _allProducts = products;
      if (products.isEmpty) {
        emit(ProductEmpty());
      } else {
        emit(ProductLoaded(allProducts: products, filteredProducts: products));
      }
    } catch (e) {
      emit(ProductError('Failed to fetch products'));
    }
  }

  void searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered = _allProducts.where((product) {
      return product.title.toLowerCase().contains(lowerQuery);
    }).toList();

    emit(ProductLoaded(allProducts: _allProducts, filteredProducts: filtered));
  }
}

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_veevo_tech/cubits/product/product_state.dart';
import 'package:dio/dio.dart';

import '../../models/product/product.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio;

  ProductCubit(this.dio) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      final response = await dio.get('https://fakestoreapi.com/products');
      final data = response.data as List;
      final products = data.map((json) => Product.fromJson(json)).toList();
      if (products.isEmpty) {
        emit(ProductEmpty());
      } else {
        emit(ProductLoaded(products));
      }
    } catch (e) {
      emit(ProductError('Failed to fetch products'));
    }
  }
}

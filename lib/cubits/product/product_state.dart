import 'package:equatable/equatable.dart';
import '../../models/product/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;

  const ProductLoaded({
    required this.allProducts,
    required this.filteredProducts,
  });

  @override
  List<Object?> get props => [allProducts, filteredProducts];
}

class ProductEmpty extends ProductState {}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

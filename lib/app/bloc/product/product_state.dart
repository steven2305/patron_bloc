part of 'product_bloc.dart';

class ProductState {

  final List<Product> products;

  ProductState({
    this.products,
  });

  ProductState copyWith({
    List<Product> products,
  }) => ProductState(
    products: products ?? this.products,
  );

}
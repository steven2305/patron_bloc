part of 'products_bloc.dart';

class ProductState {

  final bool existeProduct;
  final Product product;

  ProductState({ Product product }) 
    : product = product ?? null,
      existeProduct = ( product != null ) ? true : false;

  ProductState copyWith({ Product product }) => ProductState(
    product: product ?? this.product,
  );

  ProductState estadoInicial() => new ProductState();
}
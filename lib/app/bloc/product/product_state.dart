part of 'product_bloc.dart';

@immutable
abstract class IProductState {
}

class ProductState extends IProductState {

  final List<Product> products;
  final List<Product> cart;

  ProductState({
    this.products,
    this.cart,
  });

  ProductState copyWith({
    List<Product> products,
    List<Product> cart,
    int index,
    bool isLoading,
  }) => ProductState(
    products: products ?? this.products,
    cart: cart ?? this.cart,
  );

  int get total {
    if(this.cart == null) return 0;
    int total = 0;
    this.cart.forEach((p) => total += (p.price * p.quantity));
    return total;
  }
}


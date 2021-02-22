import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:prueba_bloc/app/models/fetch_response.dart';

import 'package:prueba_bloc/app/models/product_model.dart';
import 'package:prueba_bloc/app/utils/contants.dart';

import 'product_repository.dart';
part 'product_state.dart';
part 'product_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepository repository = new ProductRepository(dio: Dio(baseOptions));
  String cartId = '';
  ProductBloc():super( ProductState() );
  

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {   
    
    if(event is GetProducts) {
      yield await this.getProducts();
    }
    else if(event is AddToCar) {

      yield this.addToCart(event);

      final Product product = await this.updateProductOnDB(event.product);

      yield this.updateCar(product, 0);
    }

  }

  Future<ProductState> getProducts() async {

    final FetchResponse<List<Product>> response = await this.repository.getProducts(this.cartId);

    final List<Product> products = response.data;

    return this.state.copyWith(
      products: products,
    );
  }

  ProductState addToCart(AddToCar event) {

    Product product;

    if(state.cart != null) {
      
      final int index = state.cart.indexWhere((p) => p.id == event.product.id);

      if(index > -1) {

        product = this.state.cart[index].copyWith(
          quantity: event.product.quantity,
        );

        return this.updateCar(product, index);

      } else {
        return this.updateCar(event.product, -1);
      }

    } else {
      return this.updateCar(event.product, -1);
    }
  }

  ProductState updateCar(Product product, int index) {

    List<Product> cartList = [];

    if(this.state.cart == null) {
      cartList.add(product);
    } else {

      cartList = this.state.cart.map((p) {

        if(p.id == product.id) {
          p = product;
        }

        return p;
      }).toList();

      if(index == -1) {
        cartList.add(product);
      }
    }

    final List<Product> products = this.state.products.map((p) {

      if(p.id == product.id) {
        p = product;
      }

      return p;
    }).toList();


    return state.copyWith(
      cart: cartList,
      products: products,
    );
  }

  Future<Product> updateProductOnDB(Product product) async {

    if(product.idCar.length == 0) {

      final FetchResponse<String> response = await this.repository.addToCart({
        'cart_id': this.cartId,
        'product_id': product.id,
        'quantity': product.quantity
      });

      product = product.copyWith(
        idCar: response.data
      );
      
    } else {
      await this.repository.updateProcuctCart(
        product.idCar,
        {
          'cart_id': this.cartId,
          'product_id': product.id,
          'quantity': product.quantity
        }
      );
    }

    return product;
  }




}


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_bloc/app/models/fetch_response.dart';

import 'package:prueba_bloc/app/models/product_model.dart';

import 'product_repository.dart';
part 'product_state.dart';
part 'product_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepository repository = new ProductRepository();

  ProductBloc():super( ProductState() );

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {   
    
    if(event is GetProducts) {
      yield await this.getProducts();
    }

  }

  Future<ProductState> getProducts() async {

    final FetchResponse<List<Product>> response = await this.repository.getProducts();

    final List<Product> products = response.data;

    return this.state.copyWith(
      products: products,
    );
  }



}
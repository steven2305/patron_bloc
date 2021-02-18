

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_bloc/app/models/product_model.dart';


part 'products_state.dart';
part 'products_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>{

  ProductBloc():super( ProductState() );

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {   
    
      if ( event is ActivarProduct ) {
        yield state.copyWith(
          product: event.product
        );

      } else if ( event is CambiarEdad ) {
        yield state.copyWith(
          product: state.product.copyWith( sku: event.edad ) 
        );
        
      } else if ( event is AgregarProfesion ) {

        yield state.copyWith(
          product: state.product.copyWith(
          
          )
        );

      } else if ( event is BorrarProduct ) {
        yield state.estadoInicial();
      }

  }



}
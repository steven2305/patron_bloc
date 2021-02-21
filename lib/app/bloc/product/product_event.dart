part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetProducts extends ProductEvent {}

class AddToCar extends ProductEvent {

  final Product product;
  AddToCar(this.product);

}



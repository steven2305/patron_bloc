part of 'products_bloc.dart';

@immutable
abstract class ProductEvent {}

class ActivarProduct extends ProductEvent {

  final Product product;
  ActivarProduct(this.product);
  
}

class CambiarEdad extends ProductEvent {
  final int edad;
  CambiarEdad(this.edad);
}

class AgregarProfesion extends ProductEvent {

  final String profesion;
  AgregarProfesion(this.profesion);

}

class BorrarProduct extends ProductEvent {}
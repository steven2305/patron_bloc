import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prueba_bloc/app/models/fetch_response.dart';
import 'package:prueba_bloc/app/models/product_model.dart';

class ProductRepository {

  final Dio dio;

  ProductRepository({
    this.dio
  });


  Future<Map<String, dynamic>> getProducts(String cartID) async {

    if(cartID.length == 0) {
      final FetchResponse<String> responseCart = await this.createCart();
      cartID = responseCart.data ?? '';
    }

    Response response;

    try {
      response = await this.dio.get('/products.json');
    } catch (e) {
      return {
      "code": response.statusCode,
      "message": "not work"
    };
    }

    if(response.statusCode != 200 && response.statusCode != 201) return {
      "code": response.statusCode,
      "message": "not work"
    };

    final Map<String, dynamic> data = response.data;

    List<Product> products = [];

    data.forEach((id, value) {

      final Map<String, dynamic> json = {
        'id': id,
        'active': value['active'],
        'name': value['name'],
        'picture': value['picture'],
        'price': value['price'],
        'sku': value['sku'],
      };

      final Product product = Product.fromJson(json);

      products.add(product);
    });

    return {
      'ok': true,
      'products': products,
      'cartId': cartID
    };
  }

  Future<Map<String, dynamic>> updateProductCart(String id, Map<String, dynamic> jsonC) async {

    Response response;

    final String data = json.encode(jsonC);

    try {
      response = await this.dio.put('/product_cars/$id.json', data: data);
    } catch (e) {
      return {
      "code": response.statusCode,
      "message": "not work"
    };
    }

    if(response.statusCode != 200 && response.statusCode != 201) return {
      "code": response.statusCode, 
      "message": "not work"
    };

    final Product product = Product.fromJson(response.data);

   return {
      'ok': true,
      'product': product
    };
  }

  Future<FetchResponse<String>> addToCart(Map<String, dynamic> body) async {

    Response response;

    final String data = json.encode(body);

    try {
      response = await this.dio.post(
        '/product_cars.json',
        data: data
      );
    } catch (e) {
      return FetchResponse(
        code: response.statusCode, 
        message: "not work"
      );
    }

    if(response.statusCode != 200 && response.statusCode != 201) return FetchResponse(
      code: response.statusCode, 
      message: "not work"
    );


    return FetchResponse(data: response.data['name'], code: response.statusCode);

  }

  Future<FetchResponse<String>> createCart() async {

    Response response;

    final Map<String, dynamic> body = {
      'status': 'pending'
    };

    final String data = json.encode(body);

    try {
      response = await this.dio.post(
        '/carts.json',
        data: data
      );
    } catch (e) {
      return FetchResponse(
      code: response.statusCode,
      message: "not work"
    );
    }

    if(response.statusCode != 200 && response.statusCode != 201) return FetchResponse(
      code: response.statusCode, 
      message: "not work"
    );

    return FetchResponse(data: response.data['name'], code: response.statusCode);
  }

}
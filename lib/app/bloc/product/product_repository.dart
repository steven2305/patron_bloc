import 'package:dio/dio.dart';
import 'package:prueba_bloc/app/models/fetch_response.dart';
import 'package:prueba_bloc/app/models/product_model.dart';

class ProductRepository {

  final Dio dio;

  ProductRepository({
    this.dio
  });


  Future<FetchResponse<List<Product>>> getProducts() async {


    Response response;

    try {
      response = await this.dio.get('/products.json');
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

    return FetchResponse(data: products, code: response.statusCode);
  }

}
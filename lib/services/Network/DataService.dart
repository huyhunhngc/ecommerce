import 'package:dutstore/main.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/models/ReviewProduct.dart';
import 'package:dutstore/services/Network/WebService.dart';
import 'package:dutstore/utils/Failure.dart';
import 'package:get/get.dart';

abstract class IDataServices {
  Future<List<Product>> getLatestProducts(int pageSize, int page);

  Future<List<Product>> getAllProducts(int pageSize, int page);

  Future<List<Product>> getProductsByBrand(String brand);

  Future<List<Product>> getProductsByDiscount(int pageSize, int page);

  Future<List<Product>> filterProducts(String query);

  Future<List<Product>> recommendProducts();

  Future<List<ReviewProduct>> getAllReviewProduct(String productId);
}

class DataServices implements IDataServices {
  final WebService _webService = Get.find();

  @override
  Future<List<Product>> filterProducts(String query) async {
    var response = await _webService.dio.get(APIRoute.searchProduct.path,
        queryParameters: {'text_search': query});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> getAllProducts(int pageSize, int page) async {
    var response = await _webService.dio.get(APIRoute.product.path,
        queryParameters: {'page_number': page, 'limit': pageSize});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> getLatestProducts(int pageSize, int page) async {
    var response = await _webService.dio.get(APIRoute.product.path,
        queryParameters: {'page_number': page, 'limit': pageSize});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> getProductsByBrand(String brand) async {
    var response = await _webService.dio.get(APIRoute.productByBrand.path,
        queryParameters: {'brand_name': brand});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> getProductsByDiscount(int pageSize, int page) async {
    var response = await _webService.dio.get(APIRoute.productByDiscount.path,
        queryParameters: {'page_number': page, 'limit': pageSize});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<ReviewProduct>> getAllReviewProduct(String productId) async {
    var response = await _webService.dio.get(APIRoute.reviewByIdProduct.path,
        queryParameters: {'product_id': productId});
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => ReviewProduct.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> recommendProducts() async {
    var response = await _webService.dio.get(
      APIRoute.recommendProduct.path,
      queryParameters: {'user_id': cookie},
    );
    var jsonData = response.data['data'] as List;

    if (response.data['status_code'] != 200)
      return Future.error(Failure(response.data['message']));
    return jsonData.map((e) => Product.fromJson(e)).toList();
  }
}

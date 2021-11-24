import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:dutstore/utils/Failure.dart';
import 'package:dutstore/utils/Keys.dart';

class WebService extends GetxService {
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    dio.options.baseUrl = BASEAPIURL;
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) {
        return handler.next(DioError(
            requestOptions: e.requestOptions,
            error: Failure("BACKEND_GENERAL_ERROR_MESSAGE".tr)));
      },
    ));
  }

  @override
  void onClose() {
    super.onClose();
  }
}

enum APIRoute {
  public,
  getProvince,
  auth,
  login,
  register,
  updateProfile,
  getUserProfile,
  image,
  category,
  categoryImage,
  product,
  productByTypes,
  productByBrand,
  productByDiscount,
  searchProduct,
  recommendProduct,
  avataImage,
  reviewByIdProduct,
  deleteReview,
  createReview,
}

extension APIRouteExtention on APIRoute {
  String get path {
    switch (this) {
      case APIRoute.getUserProfile:
        return '/api/users/private';
      case APIRoute.auth:
        return '/auth';
      case APIRoute.login:
        return '/api/users/login';
      case APIRoute.register:
        return '/api/users/create';
      case APIRoute.updateProfile:
        return 'api/users/update-information';
      case APIRoute.public:
        return '/public';
      case APIRoute.getProvince:
        return '/public/province/';
      case APIRoute.image:
        return '/image';
      case APIRoute.category:
        return '/public/category';
      case APIRoute.categoryImage:
        return '/image/';
      case APIRoute.product:
        return '/api/products/get-products';
      case APIRoute.productByTypes:
        return '/api/products/get-products-by-type';
      case APIRoute.productByBrand:
        return '/api/products/get-products-by-brand';
      case APIRoute.productByDiscount:
        return '/api/products/get-products-by-discount';
      case APIRoute.searchProduct:
        return '/api/products/search-product';
      case APIRoute.recommendProduct:
        return '/api/recommended-system';
      case APIRoute.createReview:
        return '/api/review/create';
      case APIRoute.reviewByIdProduct:
        return '/api/review/get-review-by-product-id';
      case APIRoute.deleteReview:
        return '/api/review/delete';
      case APIRoute.avataImage:
        return '/image/avata/';
    }
  }
}

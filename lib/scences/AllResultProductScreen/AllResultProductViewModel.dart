import 'dart:async';

import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/models/TypeViewAll.dart';
import 'package:dutstore/services/Network/DataService.dart';
import 'package:get/get.dart' hide Rx;
import 'package:rxdart/rxdart.dart';

class AllResultProductViewModel extends BaseViewModel{
  final DataServices _dataServices = DataServices();

  final isLoadingData = BehaviorSubject.seeded(false);
  final product = BehaviorSubject<List<Product>>();
  final title = BehaviorSubject<String>();

  dynamic argument = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (argument[0]['types'] == TypeView.brand) {
      title.add(argument[1]['tag'].toString().toUpperCase());
     _dataServices.getProductsByBrand(argument[1]['tag']).then((value) => product.add(value));
    } else {
      _dataServices.getAllProducts(100, 1).then((value) => product.add(value));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 2));
    product.add([]);
  }


  sortProduct() {
    //var latestState
  }

  @override
  void onClose() {
    super.onClose();
    isLoadingData.close();
    product.close();
  }
}
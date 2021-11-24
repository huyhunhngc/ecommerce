import 'dart:async';

import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/services/Network/DataService.dart';
import 'package:get/get.dart' hide Rx;
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

const int pageSize = 10;

class HomeViewModel extends BaseViewModel {
  final DataServices _dataServices = DataServices();

  final loadFirstPage = BehaviorSubject<void>();
  final loadMore = BehaviorSubject<void>();
  final loadAllController = BehaviorSubject<void>();
  late StreamSubscription<void> _subscriptionReachMax;
  late StreamSubscription<Object> _subscriptionError;

  late ValueConnectableStream<List<Product>> _productList;
  late Stream<List<Product>> mergeStream;
  final isLoadingData = BehaviorSubject.seeded(false);
  final product = BehaviorSubject<List<Product>>();

  final hotSaleProduct = BehaviorSubject<List<Product>>();
  final latestProduct = BehaviorSubject<List<Product>>();

  @override
  void onInit() {
    super.onInit();
    loadMore.listen((_) {});
    final more = loadMore
        .throttleTime(Duration(milliseconds: 500))
        .map((_) => false)
        .exhaustMap(loadMoreProduct);

    final firstPage =
        loadFirstPage.map((_) => true).exhaustMap(loadMoreProduct);
    final mergeStream = Rx.merge([firstPage, more]);
    _productList =
        Rx.switchLatest(mergeStream.map((state) => Stream.value(state)))
            .distinct()
            .publishValueSeeded([]);
    _productList.connect();
    _dataServices.getProductsByDiscount(20, 0).then((list) {
      hotSaleProduct.add(list);
    });
    _dataServices.getLatestProducts(20, 1).then((list) {
      latestProduct.add(list);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 2));
    _productList.value!.clear();
    product.add([]);
    loadMore.add(null);
  }

  Stream<List<Product>> get productList => _productList;

  Stream<List<Product>> loadMoreProduct(bool firstPage) async* {
    final lastestState = _productList.value;
    if (firstPage) {
      _productList.value!.clear();
      lastestState!.clear();
    }
    final currentListLength = lastestState!.length;
    isLoading.add(true);

    final pageList = await _dataServices.getAllProducts(
        pageSize, currentListLength ~/ pageSize + 1);

    try {
      if (pageList.isBlank!) {
        loadAllController.add(null);
        isLoading.add(false);
      } else
        lastestState.insertAll(currentListLength, pageList);
    } catch (e) {}
    product.add(lastestState);
    yield lastestState;

    isLoading.add(false);
  }

  @override
  void onClose() {
    super.onClose();
    _subscriptionError.cancel();
    _subscriptionReachMax.cancel();
    isLoadingData.close();
    hotSaleProduct.close();
    latestProduct.close();
  }
}

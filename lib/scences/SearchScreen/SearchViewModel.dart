import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/services/Network/DataService.dart';
import 'package:get/get.dart' hide Rx;
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:get/get_utils/get_utils.dart';

class SearchViewModel extends BaseViewModel {
  final DataServices _dataServices = DataServices();
  final searchTextfiledTrigger = BehaviorSubject<String?>();
  final loadSearchList = BehaviorSubject<void>();
  final loadSearchHistory = BehaviorSubject<void>();

  final labelActionMessage = BehaviorSubject.seeded('history_search'.tr);
  late ValueConnectableStream<List<Product>> _productList;
  final product = BehaviorSubject<List<Product>>();
  final isTypeSearching = BehaviorSubject.seeded(false);

  @override
  void onInit() {
    super.onInit();
    final searchStream = loadSearchList
        .debounceTime(Duration(milliseconds: 500))
        .map((_) => searchTextfiledTrigger.valueWrapper!.value!)
        .exhaustMap(searchQuery);
    _productList =
        Rx.switchLatest(searchStream.map((state) => Stream.value(state)))
            .distinct()
            .publishValueSeeded([]);
    _productList.connect();
    searchTextfiledTrigger.listen((value) {
      if (searchTextfiledTrigger.valueWrapper!.value != "") {
        labelActionMessage.add('result_search'.tr);
        isTypeSearching.add(true);
        loadSearchList.add(null);
      } else {
        labelActionMessage.add('history_search'.tr);
        isTypeSearching.add(false);
      }
    });
  }

  Stream<List<Product>> searchQuery(String query) async* {
    var latestState = _productList.value;

    isLoading.add(true);

    final pageList = await _dataServices.filterProducts(query);
    try {
      if (pageList.isBlank!) {
        isLoading.add(false);
      } else {
        latestState = <Product>[...pageList];
      }
    } catch (e) {}
    product.add(latestState!);
    yield latestState;

    isLoading.add(false);
  }

  @override
  void onClose() {
    super.onClose();
    searchTextfiledTrigger.close();
    labelActionMessage.close();
    loadSearchList.close();
  }
}

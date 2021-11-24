import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/models/ReviewProduct.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/services/Demo/DemoProduct.dart';
import 'package:dutstore/services/Network/DataService.dart';
import 'package:dutstore/utils/Failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DetailProductViewModel extends BaseViewModel {
  final MainViewModel _mainViewModel = Get.find();
  final DataServices _dataServices = DataServices();

  //Inputs
  final selectedTapImage = BehaviorSubject.seeded(0);
  final selectedChangeImage = BehaviorSubject.seeded(0);
  final checkConstainsInCartTrigger = BehaviorSubject<String>();
  final commentInput = BehaviorSubject<String>();
  final addToCartTrigger = BehaviorSubject<Product>();
  final recommendProduct = BehaviorSubject<List<Product>>();

  //Outputs
  final isAddedToCart = BehaviorSubject<bool>();
  final PageController pageController = PageController();
  final TextEditingController textEditingController = TextEditingController();
  final loadMoreReview = BehaviorSubject<List<ReviewProduct>>();

  @override
  void onInit() {
    super.onInit();
    addToCartTrigger.listen((value) {
      if (isAddedToCart.valueWrapper!.value) {
        showFailure(Failure('ready_in_cart'.tr));
      } else {
        _mainViewModel.addToCartTrigger.add(value);
        isAddedToCart.add(true);
      }
    });

    selectedTapImage.listen((value) {
      pageController.animateToPage(value,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      selectedChangeImage.add(value);
    });

    _dataServices.recommendProducts().then((value) => recommendProduct.add(value));
  }

  bool isItemConstainsInCart(String id) {
    return demoCarts.listItem
            ?.map((cartItem) => cartItem.product?.id)
            .toList()
            .contains(id) ??
        false;
  }

  loadComment(String productId) {
    _dataServices
        .getAllReviewProduct(productId)
        .then((value) => loadMoreReview.add(value));
  }

  addComment() {
    textEditingController.clear();
    var state = loadMoreReview.value ?? [];
    final first = loadMoreReview.value?.first;
    if (first != null) {}
    state.insert(0,
        ReviewProduct(id: first?.id ?? "123", description: commentInput.value));
    loadMoreReview.add(state);
  }

  @override
  void onClose() {
    super.onClose();
    selectedTapImage.close();
    selectedChangeImage.close();
    isAddedToCart.close();
    checkConstainsInCartTrigger.close();
    addToCartTrigger.close();
    commentInput.close();
    loadMoreReview.close();
    recommendProduct.close();
  }
}

extension _DetailProductViewModel on DetailProductViewModel {
  showFailure(Failure value) {
    Get.dialog(
        CupertinoAlertDialog(
          title: Text('error'.tr),
          content: Text(value.message),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'.tr),
              isDefaultAction: true,
              onPressed: () => Get.back(),
            )
          ],
        ),
        barrierDismissible: false);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/scences/CartScreen/CartScreenViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Item/NumsOfItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({
    Key? key,
    required this.cart,
    required this.isSelected,
    required this.itemIndex,
  }) : super(key: key);

  final CartItem cart;
  final bool isSelected;
  final int itemIndex;

  final StringHelper helper = StringHelper();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<CartItemController>(
        init: CartItemController(isSelected, cart.numOfItem ?? 0),
        global: false,
        builder: (_controller) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                StreamBuilder<bool>(
                    stream: _controller.isSelectedTrigger,
                    builder: (context, snapshot) {
                      return Checkbox(
                        value: snapshot.data ?? false,
                        onChanged: (value) => _controller.addItemToOrderTrigger
                            .add(Tuple2(value ?? false, itemIndex)),
                        activeColor: primaryColor,
                      );
                    }),
                SizedBox(
                  width: 80,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: cart.product!.images![0],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.5,
                      child: Text(
                        cart.product!.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: FONT_REGULAR),
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 30,
                      width: 180,
                      margin: EdgeInsets.only(right: 2.0),
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                          ),
                          Container(
                            width: 150,
                            child: Text(
                              'White, 6GB/128GB',
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: FONT_LIGHT),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 10,
                            child: Icon(Icons.keyboard_arrow_down_rounded),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${helper.getPrice(cart.product?.price ?? 0)} ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: FONT_REGULAR,
                              color: cart.product!.priceDiscount == null
                                  ? Colors.red
                                  : Colors.grey,
                              decoration: cart.product!.priceDiscount != null
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        Visibility(
                          visible: cart.product!.priceDiscount != null,
                          child: Text(
                            "${helper.getPrice(cart.product?.priceDiscount ?? 0)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                                fontFamily: FONT_REGULAR),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<int>(
                        stream: _controller.numsOfItemTrigger,
                        builder: (context, snapshot) {
                          return NumOfItems(
                            num: snapshot.data ?? 0,
                            size: 25,
                            onTapDecrease: (snapshot.data ?? 0) > 1
                                ? () => _controller.decreaseItemTrigger
                                    .add(itemIndex)
                                : null,
                            onTapIncrease: () =>
                                _controller.increaseItemTrigger.add(itemIndex),
                          );
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class CartItemController extends GetxController {
  CartItemController(this.isSelected, this.numsOfItem);

  bool isSelected;
  int numsOfItem;

  final CartViewModel _viewModel = Get.find();

  //Inputs
  final addItemToOrderTrigger = BehaviorSubject<Tuple2<bool, int>>();
  final increaseItemTrigger = BehaviorSubject<int>();
  final decreaseItemTrigger = BehaviorSubject<int>();

  //Outputs
  final numsOfItemTrigger = BehaviorSubject<int>.seeded(0);
  final isSelectedTrigger = BehaviorSubject<bool>.seeded(false);

  @override
  void onInit() {
    numsOfItemTrigger.add(numsOfItem);
    isSelectedTrigger.add(isSelected);

    addItemToOrderTrigger.listen((value) {
      isSelectedTrigger.add(value.item1);
      if (value.item1) {
        _viewModel.addItemToOrder(value.item2);
      } else {
        _viewModel.removeItemFromOrder(value.item2);
      }
    });
    increaseItemTrigger.listen((index) {
      var recent = numsOfItemTrigger.value ?? 0;
      numsOfItemTrigger.add(recent + 1);
      _viewModel.updateCartItem(index, recent + 1);
    });
    decreaseItemTrigger.listen((index) {
      if (numsOfItemTrigger.value! > 1) {
        var recent = numsOfItemTrigger.value ?? 0;
        numsOfItemTrigger.add(recent - 1);
      } else {
        _viewModel.deleteItemOnCart(index);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    addItemToOrderTrigger.close();
    increaseItemTrigger.close();
    decreaseItemTrigger.close();
    numsOfItemTrigger.close();
    isSelectedTrigger.close();
  }
}

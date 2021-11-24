import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Input/CustomDialog.dart';
import 'package:dutstore/widgets/Input/CustomElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'CartScreenViewModel.dart';
import 'Component/CartCard.dart';

class CartScreen extends StatelessWidget {
  final CartViewModel _viewModel = Get.find();
  final StringHelper helper = StringHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "your_cart".tr,
          style: TextStyle(fontFamily: FONT_BOLD),
        ),
        elevation: 0.5,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              constraints: BoxConstraints(minHeight: 50),
              width: double.maxFinite,
              color: primaryColor.withOpacity(0.15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SvgPicture.asset(ICONS_FLASH),
                  ),
                  Expanded(
                    child: Text(
                      'intro_text_cart'.tr,
                      style: TextStyle(
                          color: primaryColor, fontFamily: FONT_REGULAR),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildCartList(context)),
            _buildCheckoutCard(context),
          ],
        ),
      ),
    );
  }
}

extension _CartScreenItem on CartScreen {
  void showConfirmDeleteDialog(int index) {
    Get.dialog(
      CustomDialog(
        textTitle: 'delete_items_warning'.tr,
        textButtonCancel: 'Cancel',
        textButtonConfirm: 'OK',
        confirmOnPress: () {
          _viewModel.deleteItemTrigger.add(index);
          Get.back();
        },
      ),
    );
  }

  Widget _buildCartList(BuildContext context) {
    return StreamBuilder<List<CartItem>>(
      stream: _viewModel.listCartItem,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Slidable(
                    actionPane: SlidableScrollActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        color: Colors.red.withOpacity(0.2),
                        iconWidget: SvgPicture.asset(
                          ICONS_TRASH,
                          height: 30,
                          width: 30,
                          color: Colors.red,
                        ),
                        onTap: () => showConfirmDeleteDialog(index),
                      )
                    ],
                    child: CartItemCard(
                      cart: snapshot.data![index],
                      isSelected: _viewModel.checkItemIsSelected(index),
                      itemIndex: index,
                    ),
                  ),
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget _buildCheckoutCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      // height: 174,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text(
                  "Add voucher code",
                  style: TextStyle(fontFamily: FONT_LIGHT),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: _viewModel.totalAmount,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "total".tr + '\n',
                        children: [
                          TextSpan(
                            text: "${helper.getPrice(snapshot.data ?? 0)}",
                            style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontFamily: FONT_BOLD),
                          ),
                        ],
                      ),
                    ),
                    CustomElevatedButton(
                      onPress: () => _viewModel.checkoutButtonTrigger.add(null),
                      width: 200,
                      height: 50,
                      text: 'Check out',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/scences/PlaceOrderScreen/PlaceOrderViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Input/CustomElevatedButton.dart';
import 'package:dutstore/widgets/Item/AppDropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'Component/PriceItem.dart';
import 'Component/ProductItem.dart';

class PlaceOrderScreen extends StatelessWidget {
  final StringHelper helper = StringHelper();
  final PlaceOrderViewModel _viewModel = Get.find();
  final TextStyle titleStyle = TextStyle(
    fontSize: 15.0,
    color: kTextColor,
    fontFamily: FONT_REGULAR,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: kPrimaryColor,
        title: Text(
          "address".tr,
          style: TextStyle(fontFamily: FONT_BOLD),
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: AppDropdownArea(
                  body: (controller) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleSection('delivery_to'.tr),
                      _selectedAddressSection(),
                      titleSection('delivery_type'.tr),
                      _deliveryOption(),
                      _dropdownButton(
                          values: _viewModel.deliveryTypes,
                          assetValues: _viewModel.deliveryTypesAsset,
                          hint: 'delivery_type'.tr,
                          currentIndex: _viewModel.deliveryType,
                          controller: controller),
                      titleSection('order_list'.tr),
                      _orderListSection(),
                      titleSection('oder_bill'.tr),
                      _priceSection()
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: _viewModel.totalAmount,
              builder: (context, snapshot) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
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
                        onPress: () => Get.back(),
                        width: 200,
                        height: 50,
                        text: 'place_order'.tr,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}

extension _PlaceOrderScreen on PlaceOrderScreen {
  showThankYouBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Text(
                    "thanks_for_purchase".tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    onPress: () {
                      Get.back();
                    },
                    width: 200,
                    height: 50,
                    text: 'track_order'.tr,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget titleSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text(title, style: titleStyle),
    );
  }

  Widget _selectedAddressSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 12, top: 8, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _addressItem(
                  _viewModel.userFullName, Icons.account_circle, primaryColor),
              InkWell(
                onTap: () => Get.toNamed(Routes.GOOGLE_MAP_PICK),
                child: Container(
                    width: 60,
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          _addressItem(_viewModel.userAddress, Icons.place, Colors.red),
          _addressItem(
              _viewModel.userPhoneNumber, Icons.call, Colors.greenAccent),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _deliveryOption() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 20, top: 8, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  StreamBuilder<int>(
                    stream: _viewModel.deliveryTime,
                    builder: (context, snapshot) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'delivery_in'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FONT_REGULAR),
                            ),
                            TextSpan(
                              text: " ${snapshot.data} ",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontFamily: FONT_REGULAR),
                            ),
                            TextSpan(
                              text: 'hours'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FONT_REGULAR),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderListSection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) => ProductItem(
          product: _viewModel.orderProduct.item2[index].product!,
          itemCount: _viewModel.orderProduct.item2[index].numOfItem!,
        ),
        itemCount: _viewModel.orderProduct.item2.length,
      ),
    );
  }

  Widget _priceSection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          _priceItem(_viewModel.totalMRP, "total_mrp".tr, Colors.grey.shade700),
          _priceItem(_viewModel.discount, "discount".tr, primaryColor),
          _priceItem(
              _viewModel.orderTotal, "order_total".tr, Colors.grey.shade700),
          StreamBuilder<int>(
            stream: _viewModel.deliveryFee,
            builder: (context, snapshot) {
              int fee = snapshot.data ?? 0;
              String deliveryFee = fee == 0 ? "free".tr : helper.getPrice(fee);
              return PriceItem(
                  "delivery_charge".tr, deliveryFee, Colors.teal.shade300);
            },
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _addressItem(Stream<String> data, IconData icon, Color iconColor) {
    return StreamBuilder<String>(
      stream: data,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                snapshot.data ?? 'no_info'.tr,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _priceItem(Stream<int> data, String title, Color colortext) {
    return StreamBuilder<int>(
      stream: data,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? PriceItem(title, helper.getPrice(snapshot.data ?? 0), colortext)
            : CircularProgressIndicator();
      },
    );
  }

  Widget _dropdownButton({
    required List<String> values,
    required List<String> assetValues,
    required String hint,
    required BehaviorSubject<int?> currentIndex,
    required AppDropdownController controller,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: AppDropdownButton(
        values: values,
        assetValues: assetValues,
        hint: hint,
        currentIndex: currentIndex,
        controller: controller,
      ),
    );
  }
}

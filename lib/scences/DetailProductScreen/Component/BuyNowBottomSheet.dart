import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Cart.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/DetailProductScreen/BuyNowViewModel.dart';
import 'package:dutstore/scences/DetailProductScreen/Component/SelectableField.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Input/CustomElevatedButton.dart';
import 'package:dutstore/widgets/Item/NumsOfItems.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomSheetSelect extends StatelessWidget {
  final Product? product;
  final MainViewModel _mainViewModel = Get.find();
  final BuyNowViewModel _buyNowViewModel = Get.put(BuyNowViewModel());
  final StringHelper helper = StringHelper();

  BottomSheetSelect({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowViewModel>(
        initState: (state) {
          _buyNowViewModel.price.add(
              product?.priceDiscount ?? (product?.price ?? 0));
          _buyNowViewModel.product.add(product!);
        },
        builder: (_) {
          return Container(
            constraints: BoxConstraints(minHeight: 300),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      iconSize: 20,
                      icon: CloseButton(),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  _buildProductTile(context),
                  Divider(
                    thickness: 1.0,
                  ),
                  Expanded(child: _buildSelector(context)),
                  CustomElevatedButton(
                    text: 'place_order'.tr,
                    height: 50,
                    width: 80.0.w,
                    marginVerti: 10,
                    onPress: () {
                      _buyNowViewModel.checkoutButtonTrigger.add(null);
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Options'.tr,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: FONT_REGULAR,
                  ),
                ),
              ),
              SelectableField(
                  _buyNowViewModel.values,
                  _buyNowViewModel.selectedIndexOption,
                  _buyNowViewModel.outputOptions)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'nums_of_item'.tr,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: FONT_REGULAR,
                ),
              ),
              StreamBuilder<int>(
                  stream: _buyNowViewModel.changeNumsOfItemTrigger,
                  builder: (context, snapshot) {
                    return NumOfItems(
                      num: snapshot.data ?? 1,
                      size: 30,
                      onTapDecrease: () =>
                          _buyNowViewModel.changeItemsCount(false),
                      onTapIncrease: () =>
                          _buyNowViewModel.changeItemsCount(true),
                    );
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      subtitle: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: helper.getURLProduct(
                product!.images![0],
              ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                );
              },
              errorWidget: (context, _, error) =>
                  SvgPicture.asset(PRODUCT_PLACEHOLDER),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product!.name,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: FONT_LIGHT, fontSize: 18, color: Colors.black),
              ),
              Row(
                children: [
                  Visibility(
                    child: Text(
                      product!.priceDiscount != null
                          ? helper.getPrice(product!.priceDiscount!)
                          : '',
                      style: TextStyle(
                        fontFamily: FONT_BOLD,
                        color: Colors.red,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    visible: product!.priceDiscount != null,
                  ),
                  Visibility(
                    child: Container(
                      width: 10,
                    ),
                    visible: product!.priceDiscount != null,
                  ),
                  Text(
                    helper.getPrice(product!.price!),
                    style: TextStyle(
                        fontFamily: FONT_BOLD,
                        color: product!.priceDiscount == null
                            ? Colors.red
                            : Colors.grey,
                        fontSize: 12.0.sp,
                        decoration: product!.priceDiscount != null
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

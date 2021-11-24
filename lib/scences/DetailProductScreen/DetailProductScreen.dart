import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/models/ReviewProduct.dart';
import 'package:dutstore/scences/DetailProductScreen/Component/CommentItem.dart';
import 'package:dutstore/scences/DetailProductScreen/Component/RecommendProducts.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/ActionAppbar.dart';
import 'package:dutstore/widgets/Item/StarRating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

import 'Component/BuyNowBottomSheet.dart';
import 'Component/CarouselImage.dart';
import 'DetailProductViewModel.dart';

class DetailProductScreen extends StatefulWidget {
  late final Product? product;
  late final DetailProductViewModel viewModel;
  final MainViewModel mainViewModel = Get.find();

  DetailProductScreen({Key? key, required this.product}) : super(key: key) {
      Get.put(DetailProductViewModel(), tag: product!.id.toString());
  }

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final StringHelper helper = StringHelper();

  @override
  void initState() {
    widget.viewModel = Get.find(tag: widget.product!.id.toString());
    widget.viewModel.isAddedToCart
        .add(widget.viewModel.isItemConstainsInCart(widget.product!.id));
    widget.viewModel.loadComment(widget.product?.id ?? "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              primary: false,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  elevation: 0.4,
                  backgroundColor: Colors.grey[200],
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: primaryColor,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  actions: [
                    StreamBuilder<int>(
                      stream: widget.mainViewModel.cartOrderCount,
                      builder: (context, snapshot) {
                        return ActionCart(
                          count: snapshot.data,
                        );
                      },
                    ),
                  ],
                  expandedHeight: 30.0.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ProductImage(
                        viewModel: widget.viewModel,
                        images: widget.product!.images),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: ProductImage(
                              viewModel: widget.viewModel,
                              images: widget.product!.images)
                          .buildTapSelect(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildProductInfo(context),
                ),
                SliverToBoxAdapter(
                  child: _buildDescription(context),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(5.0),
                    color: Colors.white,
                    child: RelatedProduct(product: widget.viewModel.recommendProduct,),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200]),
                            child: TextField(
                              controller: widget.viewModel.textEditingController,
                              onChanged: (value) {
                                widget.viewModel.commentInput.add(value);
                              },
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                              decoration: InputDecoration.collapsed(
                                border: InputBorder.none,
                                hintText: 'Aa...',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontFamily: FONT_LIGHT),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.send_rounded),
                            onPressed: () {
                              widget.viewModel.addComment();
                            },
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child:
                      _buildComment(context, widget.viewModel.loadMoreReview),
                )
              ],
            ),
          ),
          _buildBottomAction(context),
        ],
      ),
    );
  }
}

extension _DetailProduct on _DetailProductScreenState {
  Widget _buildProductInfo(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product!.name,
              style: TextStyle(
                fontFamily: FONT_BOLD,
                fontSize: 16.0.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Visibility(
                  child: Text(
                    widget.product!.priceDiscount != null
                        ? helper.getPrice(widget.product!.priceDiscount!)
                        : '',
                    style: TextStyle(
                      fontFamily: FONT_BOLD,
                      color: Colors.red,
                      fontSize: 15.0.sp,
                    ),
                  ),
                  visible: widget.product!.priceDiscount != null,
                ),
                Visibility(
                  child: Container(
                    width: 10,
                  ),
                  visible: widget.product!.priceDiscount != null,
                ),
                Text(
                  helper.getPrice(widget.product!.price!),
                  style: TextStyle(
                      fontFamily: FONT_BOLD,
                      color: widget.product!.priceDiscount == null
                          ? Colors.red
                          : Colors.grey,
                      fontSize: 15.0.sp,
                      decoration: widget.product!.priceDiscount != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20.0),
            child: StarRating(
              width: 100,
              rating: 4.5,
            ),
          ),
          StreamBuilder<bool>(
            stream: widget.viewModel.isAddedToCart,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data ?? false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  constraints: BoxConstraints(minHeight: 50),
                  width: double.maxFinite,
                  color: primaryColor.withOpacity(0.15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SvgPicture.asset(ICONS_CHECK),
                      ),
                      Expanded(
                        child: Text(
                          'ready_in_cart'.tr,
                          style: TextStyle(
                              color: primaryColor, fontFamily: FONT_REGULAR),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComment(
      BuildContext context, BehaviorSubject<List<ReviewProduct>> review) {
    return StreamBuilder<List<ReviewProduct>>(
      stream: review,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Card(
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data!
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CommentItem(
                              review: e,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 15),
            child: Text(
              'description'.tr,
              style: TextStyle(
                fontFamily: FONT_BOLD,
                fontSize: 12.0.sp,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.product!.description!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: FONT_REGULAR,
                fontSize: 12.0.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      height: 7.0.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () =>
                  widget.viewModel.addToCartTrigger.add(widget.product!),
              child: Container(
                padding: EdgeInsets.all(15),
                height: 7.0.h,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  ICONS_CART,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  BottomSheetSelect(product: widget.product),
                  isDismissible: true,
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                height: 8.0.h,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(180),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'buy_now'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FONT_BOLD,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductScreen.dart';
import 'package:dutstore/scences/HomeScreen/Component/BrandList.dart';
import 'package:dutstore/scences/HomeScreen/Component/Category.dart';
import 'package:dutstore/scences/HomeScreen/Component/HotDealProducts.dart';
import 'package:dutstore/scences/HomeScreen/Component/IntroSlider.dart';
import 'package:dutstore/scences/HomeScreen/Component/LastestProducts.dart';
import 'package:dutstore/scences/HomeScreen/HomeViewModel.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/widgets/ActionAppbar.dart';
import 'package:dutstore/widgets/Input/SearchField.dart';
import 'package:dutstore/widgets/Item/ProductCard.dart';
import 'package:dutstore/widgets/Loading/JumpingDots.dart';
import 'package:dutstore/widgets/SectionTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreen({Key? key}) : super(key: key);
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  final ScrollController? scrollController = ScrollController();
  final MainViewModel _mainViewModel = Get.find();
  final HomeViewModel viewModel = Get.find();

  @override
  void initState() {
    super.initState();
    scrollController!.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(initState: (state) {
      viewModel.loadFirstPage.add(null);
    }, builder: (_) {
      return RefreshIndicator(
        onRefresh: viewModel.refresh,
        child: StreamBuilder<List<Product>?>(
            stream: viewModel.product,
            builder: (context, snapshot) {
              return CustomScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 20.0.h,
                    title: SearchField(onPress: () {
                      Get.toNamed('/search');
                    }),
                    flexibleSpace: FlexibleSpaceBar(
                      background: IntroSlider(),
                    ),
                    actions: <Widget>[
                      StreamBuilder<int>(
                        stream: _mainViewModel.cartOrderCount,
                        builder: (context, snapshot) {
                          return ActionCart(
                            count: snapshot.data,
                          );
                        },
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Categories(),
                  ),
                  SliverToBoxAdapter(
                    child: BrandList(),
                  ),
                  SliverToBoxAdapter(
                    child: LastestProduct(product: viewModel.latestProduct),
                  ),
                  SliverToBoxAdapter(
                    child: HotDeal(product: viewModel.hotSaleProduct),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SectionTitle(
                        title: 'All Products',
                        press: () {},
                      ),
                    ),
                  ),
                  buildAllProduct(context, snapshot),
                  SliverToBoxAdapter(
                    child: viewModel.isLoading.valueWrapper!.value
                        ? Container(
                            height: 10.0.h,
                            child: JumpingDots(),
                          )
                        : Container(),
                  ),
                ],
              );
            }),
      );
    });
  }

  Widget buildAllProduct(BuildContext context, AsyncSnapshot snapshot) {
    return snapshot.hasData
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
                crossAxisCount: 2),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: index % 2 == 0
                    ? EdgeInsets.only(left: 10)
                    : EdgeInsets.only(right: 10),
                child: ProductCard(
                  product: snapshot.data![index],
                  isGridView: true,
                  onTap: () {
                    Get.to(
                        () => DetailProductScreen(
                              product: snapshot.data![index],
                            ),
                        transition: Transition.rightToLeft);
                  },
                ),
              );
            }, childCount: snapshot.data!.length),
          )
        : SliverToBoxAdapter(child: Container());
  }
  void _onScroll() {
    if (scrollController!.offset + 50 >=
        scrollController!.position.maxScrollExtent - 50) {
      viewModel.loadMore.add(null);
    }
  }
}

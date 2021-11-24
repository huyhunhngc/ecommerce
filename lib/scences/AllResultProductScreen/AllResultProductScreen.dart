import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/AllResultProductScreen/AllResultProductViewModel.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductScreen.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/widgets/ActionAppbar.dart';
import 'package:dutstore/widgets/Item/ProductCard.dart';
import 'package:dutstore/widgets/Loading/JumpingDots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllResultProductScreen extends StatefulWidget {
  const AllResultProductScreen({Key? key}) : super(key: key);

  @override
  _AllResultProductScreenState createState() => _AllResultProductScreenState();
}

class _AllResultProductScreenState extends State<AllResultProductScreen> {
  final ScrollController? scrollController = ScrollController();
  final MainViewModel _mainViewModel = Get.find();
  final AllResultProductViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          bottom: PreferredSize(
              child: filterSortListOption(),
              preferredSize: Size(double.infinity, 44)),
          title: StreamBuilder<String>(
              stream: viewModel.title,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? "GROUP BY",
                );
              }),
          elevation: 1,
          centerTitle: true,
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
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: StreamBuilder<List<Product>>(
            stream: viewModel.product,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      child: CustomScrollView(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 2 / 3,
                                    crossAxisCount: 2),
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
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
                        ],
                      ),
                      margin:
                          EdgeInsets.only(bottom: 8, left: 4, right: 4, top: 8),
                    )
                  : JumpingDots();
            }));
  }

  filterSortListOption() {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: filterRow(Icons.filter_list, "Filter"),
            flex: 30,
          ),
          divider(),
          Expanded(
            child: filterRow(Icons.sort, "Sort"),
            flex: 30,
          ),
          divider(),
          Expanded(
            child: filterRow(Icons.list, "List"),
            flex: 30,
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: 2,
      color: Colors.grey.shade400,
      height: 20,
    );
  }

  filterRow(IconData icon, String title) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          filterBottomSheetContent(),
          isDismissible: true,
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(width: 4),
            Text(
              title,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  filterBottomSheetContent() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.close,
              ),
              Text(
                "Filter",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 16),
              ),
              Text(
                "Reset",
                style: TextStyle(color: Colors.indigo, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 28),
          Container(
            child: Text("Price Range"),
            margin: EdgeInsets.only(left: 4),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Minimum",
                      hintStyle: TextStyle(color: Colors.grey.shade800),
                      focusedBorder: border,
                      contentPadding: EdgeInsets.only(
                          right: 8, left: 8, top: 12, bottom: 12),
                      border: border,
                      enabledBorder: border,
                    ),
                  ),
                ),
                flex: 47,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4),
                  height: 1,
                  color: Colors.grey,
                ),
                flex: 6,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Maximum",
                      hintStyle: TextStyle(color: Colors.grey.shade800),
                      focusedBorder: border,
                      contentPadding: EdgeInsets.only(
                          right: 8, left: 8, top: 12, bottom: 12),
                      border: border,
                      enabledBorder: border,
                    ),
                  ),
                ),
                flex: 47,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            child: Text("Item Filter", style: TextStyle(fontSize: 16)),
            margin: EdgeInsets.only(left: 4),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                "Apply Filter",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.indigo,
            ),
          )
        ],
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1));
}

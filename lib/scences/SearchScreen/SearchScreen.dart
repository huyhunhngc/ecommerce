import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductScreen.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Loading/JumpingDots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SearchViewModel.dart';

class SearchScreen extends StatelessWidget {
  final SearchViewModel _searchViewModel = Get.find();
  final StringHelper helper = StringHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      style: TextStyle(fontFamily: FONT_REGULAR),
                      onChanged: (value) {
                        _searchViewModel.searchTextfiledTrigger.add(value);
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: 'hint_search_text'.tr),
                      cursorColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.close_rounded,
                color: Colors.grey,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 50,
                child: StreamBuilder<String?>(
                  stream: _searchViewModel.labelActionMessage,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data!,
                      style:
                          TextStyle(fontFamily: FONT_BOLD, fontSize: 14.0.sp),
                    );
                  },
                ),
              ),
              Container(
                height: 40.0.h,
                child: StreamBuilder<bool>(
                  stream: _searchViewModel.isTypeSearching,
                  builder: (context, snapshot) {
                    return snapshot.data!
                        ? buildSuggestion(context)
                        : buildRecent(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuggestion(BuildContext context) {
    return StreamBuilder<List<Product>?>(
      stream: _searchViewModel.product,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                      () => DetailProductScreen(product: snapshot.data![index]),
                      transition: Transition.downToUp);
                },
                child: ListTile(
                  title: Text(
                    snapshot.data![index].name,
                    style:
                        TextStyle(fontFamily: FONT_REGULAR, fontSize: 12.0.sp),
                  ),
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                          image: NetworkImage(
                            snapshot.data![index].images![0],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        else if (snapshot.data!.isEmpty)
          return Center(
            child: Container(
              height: 40,
              child: JumpingDots(),
            ),
          );
        else
          return Center(
            child: Container(
              height: 40,
              child: JumpingDots(),
            ),
          );
      },
    );
  }

  Widget buildRecent(BuildContext context) {
    final history = ["iphone 12 promax", "xiaomi k40", "samsung"];
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(history[index]),
          leading: Icon(
            Icons.history,
            color: primaryColor,
          ),
          trailing: Icon(Icons.clear),
        );
      },
      itemCount: history.length,
    );
  }
}

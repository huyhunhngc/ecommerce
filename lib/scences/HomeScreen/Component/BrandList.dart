import 'package:dutstore/config/AppPages.dart';
import 'package:dutstore/models/TypeViewAll.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandList extends StatelessWidget {
  List<Map<String, dynamic>> categories = [
    {"icon": APPLE_BRAND, "tag": "apple"},
    {"icon": XIAOMI_BRAND, "tag": "xiaomi"},
    {"icon": HUAWEI_BRAND, "tag": "huawei"},
    {"icon": VSMART_BRAND, "tag": "vsmart"},
    {"icon": SAMSUNG_BRAND, "tag": "samsung"},
    {"icon": NOKIA_BRAND, "tag": "nokia"},
    {"icon": OPPO_BRAND, "tag": "oppo"},
    {"icon": VIVO_BRAND, "tag": "vivo"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 60,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.toNamed(
                Routes.ALL_RESULT,
                arguments: [
                  {"types": TypeView.brand},
                  {"tag": categories[index]['tag']}
                ],
              );
            },
            child: Card(
              elevation: 0.1,
              child: Container(
                width: 80,
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      categories[index]['icon'],
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}

import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../widgets/SectionTile.dart';
import 'package:dutstore/services/Demo/DemoProduct.dart';
import 'package:dutstore/widgets/Item/ProductCard.dart';

class HotDeal extends StatelessWidget {
  const HotDeal({Key? key, required this.product});

  final BehaviorSubject<List<Product>> product;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: product,
      builder: (context, snapshot) {
        return snapshot.hasData? Column(
          children: [
            Container(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(title: "Hot sale Products", press: () {}),
            ),
            Container(height: 10),
            Container(
              height: 250,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: snapshot.data!
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ProductCard(
                            product: e,
                            onTap: () {
                              Get.to(
                                      () => DetailProductScreen(
                                    product: e,
                                  ),
                                  transition: Transition.rightToLeft);
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ): Center(child: CircularProgressIndicator());
      }
    );
  }
}

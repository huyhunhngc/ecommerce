import 'package:dutstore/models/Product.dart';
import 'package:dutstore/scences/DetailProductScreen/DetailProductScreen.dart';
import 'package:dutstore/widgets/Item/ProductCard.dart';
import 'package:dutstore/widgets/SectionTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rxdart/rxdart.dart';

class RelatedProduct extends StatelessWidget {
  const RelatedProduct({Key? key, required this.product});

  final BehaviorSubject<List<Product>> product;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: product,
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(title: "Related Products", press: () {}),
            ),
            Container(height: 10),
            snapshot.hasData
                ? Container(
                    height: 250,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                child: ProductCard(
                                  product: e,
                                  onTap: () {
                                    Get.to(
                                        () => DetailProductScreen(
                                              product: e,
                                            ),
                                        preventDuplicates: false,
                                        transition: Transition.rightToLeft);
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        );
      },
    );
  }
}

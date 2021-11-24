import 'package:dutstore/services/Demo/DemoProduct.dart';
import 'package:dutstore/widgets/Item/ProductCard.dart';
import 'package:flutter/cupertino.dart';

class AllProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
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
            product: demoProducts[index],
            isGridView: true,
          ),
        );
      }, childCount: demoProducts.length),
    );
  }
}

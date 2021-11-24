import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.product, this.itemCount = 1})
      : super(key: key);
  final StringHelper helper = StringHelper();
  final Product product;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      trailing: Text(
        'x${itemCount}',
        style: TextStyle(color: primaryColor, fontFamily: FONT_BOLD),
      ),
      subtitle: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: helper.getURLProduct(
                product.images![0],
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
                product.name,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: FONT_LIGHT, fontSize: 14, color: Colors.black),
              ),
              Row(
                children: [
                  Visibility(
                    child: Text(
                      product.priceDiscount != null
                          ? helper.getPrice(product.priceDiscount!)
                          : '',
                      style: TextStyle(
                        fontFamily: FONT_BOLD,
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                    visible: product.priceDiscount != null,
                  ),
                  Visibility(
                    child: Container(
                      width: 10,
                    ),
                    visible: product.priceDiscount != null,
                  ),
                  Text(
                    helper.getPrice(product.price!),
                    style: TextStyle(
                        fontFamily: FONT_BOLD,
                        color: product.priceDiscount == null
                            ? Colors.red
                            : Colors.grey,
                        fontSize: 12.0,
                        decoration: product.priceDiscount != null
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

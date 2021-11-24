import 'package:cached_network_image/cached_network_image.dart';
import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/helper/StringHelper.dart';
import 'package:dutstore/models/Product.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Item/SalePanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dutstore/utils/AppSize.dart';
import 'StarRating.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    this.aspectRetio = 2 / 3,
    @required this.product,
    this.onTap,
    this.isGridView = false,
  }) : super(key: key);

  final double? aspectRetio;

  final Product? product;
  final Function()? onTap;
  final StringHelper helper = StringHelper();
  final bool? isGridView;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: !isGridView! ? constraints.maxHeight : null,
          width: !isGridView! ? constraints.maxHeight * aspectRetio! : null,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: product!.images![0],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: Container(
                                width: 60,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(product!.images![0]),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: constraints.maxHeight * aspectRetio!,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200]!,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product!.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: FONT_LIGHT,
                                    fontSize: 10.0.sp,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${helper.getPrice(product?.price ?? 0)} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FONT_REGULAR,
                                          fontSize: 9.0.sp,
                                          color: product!.priceDiscount == null
                                              ? Colors.red
                                              : Colors.grey,
                                          decoration:
                                              product!.priceDiscount != null
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                    ),
                                    Visibility(
                                      visible: product!.priceDiscount != null,
                                      child: Text(
                                        "${helper.getPrice(product?.priceDiscount ?? 0)}",
                                        style: TextStyle(
                                            fontSize: 9.0.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor,
                                            fontFamily: FONT_REGULAR),
                                      ),
                                    ),
                                  ],
                                ),
                                StarRating(
                                  rating: 4.5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: product?.priceDiscount != null,
                  child: Positioned(
                    right: 20,
                    child: SalePanel(
                      percentDiscount: product!.disCountPercent,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

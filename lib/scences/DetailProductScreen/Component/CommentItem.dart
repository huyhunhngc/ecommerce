import 'package:dutstore/models/ReviewProduct.dart';
import 'package:dutstore/widgets/Item/Avatar.dart';
import 'package:dutstore/widgets/Item/StarRating.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, this.review}) : super(key: key);
  final ReviewProduct? review;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        top: 1,
        bottom: 8,
        left: 3,
      ),
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Avatar(
              avatarURL:
                  "https://baominh.tech/wp-content/uploads/2020/09/nhan-dan-facebook.png",
              size: 40,
            ),
          ),
          Container(
            width: 5,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: size.width * 0.7),
            margin: EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: Colors.grey[300]),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(review?.createdAt ?? "Just now", style: TextStyle(color: Colors.blueGrey),),
                    SizedBox(
                      width: 10,
                    ),
                    review?.numberStar != null
                        ? StarRating(
                            rating: review?.numberStar?.toDouble(),
                            width: 60,
                          )
                        : Text("No rating", style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  review?.description ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

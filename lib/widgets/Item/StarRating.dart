import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double? rating;
  final double? width;
  const StarRating({Key? key, this.rating = 1, this.width = 60})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: width! + 10.0,
      child: Row(
        children: [
          ...List.generate(
            5,
            (index) {
              return (rating! - index.toDouble() > 1)
                  ? Icon(
                      Icons.star,
                      size: width! / 5,
                      color: Colors.yellow[800],
                    )
                  : ((rating! - index.toDouble() > 0 &&
                          rating! - index.toDouble() < 1)
                      ? Icon(
                          Icons.star_half,
                          size: width! / 5,
                          color: Colors.yellow[800],
                        )
                      : Icon(
                          Icons.star_border,
                          size: width! / 5,
                          color: Colors.yellow[800],
                        ));
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  PriceItem(this.keyWord, this.value, this.color);
  String keyWord;
  String value;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            keyWord,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 14),
          )
        ],
      ),
    );
  }
}

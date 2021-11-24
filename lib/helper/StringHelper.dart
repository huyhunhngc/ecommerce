import 'package:dutstore/services/Network/WebService.dart';
import 'package:dutstore/utils/Keys.dart';
import 'package:get/utils.dart';

class StringHelper {
  String getURLCategory(String path) =>
      BASEAPIURL + APIRoute.categoryImage.path + path;
  String getURLProduct(String path) => path;

  String getURLavatar(String path) => path;
  String getHappenTime(String date) {
    DateTime currentTime = DateTime.now();
    Duration time;
    try {
      int year = int.parse(date.substring(0, 4));
      int month = int.parse(date.substring(5, 7));
      int day = int.parse(date.substring(8, 10));
      int hour = int.parse(date.substring(11, 13));
      int minute = int.parse(date.substring(14, 16));
      time = currentTime.difference(DateTime(year, month, day, hour, minute));

      int minuteDuration = time.inMinutes % 60;
      int yearDuration = time.inDays ~/ 365;
      int monthDuration = (time.inDays - yearDuration * 365) ~/ 30;
      int dayDuration = time.inDays - (yearDuration * 365 + monthDuration * 30);
      int hourDuration = time.inHours -
          (yearDuration * 24 * 365 +
              monthDuration * 30 * 24 +
              dayDuration * 24);

      Map<String, int> duration = {
        "year": yearDuration,
        "month": monthDuration,
        "day": dayDuration,
        "hour": hourDuration,
        "minute": minuteDuration,
      };
      for (var item in duration.keys) {
        int value = duration[item] ?? 0;
        if (duration[item] != 0) {
          if (value > 1) item += "s";
          return "$value $item";
        }
      }
    } on Exception {
      return "";
    }
    return "now";
  }

  String getPrice(int price) {
    if (price == 0) return "₫0";
    String priceStr = price.toString();

    int count = priceStr.length % 3 == 0
        ? (priceStr.length ~/ 3 - 1)
        : priceStr.length ~/ 3;
    int length = priceStr.length;
    for (int i = 1; i <= count; i++) {
      priceStr = priceStr.substring(0, length - 3 * i - (i - 1)) +
          "," +
          priceStr.substring(length - 3 * i - (i - 1), length);
      length += 1;
    }

    return "₫$priceStr";
  }
}

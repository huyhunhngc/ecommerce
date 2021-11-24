import 'package:dutstore/utils/Assets.dart';
import 'package:get/get_utils/get_utils.dart';

enum DeliveryType { standard, fast, extra }

extension DeliveryTypeValue on DeliveryType {
  int hourDelivery() {
    switch (this) {
      case DeliveryType.standard:
        return 168;
      case DeliveryType.extra:
        return 8;
      case DeliveryType.fast:
        return 48;
    }
  }

  int hourPrepareDelivery() {
    switch (this) {
      case DeliveryType.standard:
        return 48;
      case DeliveryType.extra:
        return 24;
      case DeliveryType.fast:
        return 48;
    }
  }

  int deliveryFee() {
    switch (this) {
      case DeliveryType.standard:
        return 0;
      case DeliveryType.extra:
        return 100000;
      case DeliveryType.fast:
        return 50000;
    }
  }

  String stringValue() {
    switch (this) {
      case DeliveryType.standard:
        return 'standard';
      case DeliveryType.extra:
        return 'extra';
      case DeliveryType.fast:
        return 'fast';
    }
  }

  String assetValues() {
    switch (this) {
      case DeliveryType.standard:
        return STANDARD_DELIVERY;
      case DeliveryType.extra:
        return EXTRA_DELIVERY;
      case DeliveryType.fast:
        return FAST_DELIVERY;
    }
  }

  String displayValue() {
    switch (this) {
      case DeliveryType.standard:
        return 'standard_delivery'.tr;
      case DeliveryType.extra:
        return 'extra_delivery'.tr;
      case DeliveryType.fast:
        return 'fast_delivery'.tr;
    }
  }

  static DeliveryType? deliveryType(String value) {
    switch (value) {
      case 'standard':
        return DeliveryType.standard;
      case 'fast':
        return DeliveryType.fast;
      case 'extra':
        return DeliveryType.extra;
    }
  }
}

class DeliveryOption {
  DeliveryOption({required this.orderDate, required this.deliveryType});
  DateTime orderDate;
  DeliveryType deliveryType;
}

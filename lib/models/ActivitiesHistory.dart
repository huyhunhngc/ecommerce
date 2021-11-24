import 'package:get/get.dart';

class ActivitiesHistory {
  late Action actionHistory;
  late String content;
  late DateTime dateTime;
  ActivitiesHistory({
    required this.actionHistory,
    required this.content,
    required this.dateTime,
  });
}

enum Action { order, payment, delivery }

extension ActionValue on Action {
  String stringValue() {
    switch (this) {
      case Action.order:
        return 'order';
      case Action.payment:
        return 'payment';
      case Action.delivery:
        return 'delivery';
    }
  }

  String displayValue() {
    switch (this) {
      case Action.order:
        return 'order_history'.tr;
      case Action.payment:
        return 'payment_history'.tr;
      case Action.delivery:
        return 'delivery_history'.tr;
    }
  }

  static Action? action(String value) {
    switch (value) {
      case 'order':
        return Action.order;
      case 'payment':
        return Action.payment;
      case 'delivery':
        return Action.delivery;
    }
  }
}

import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/models/ActivitiesHistory.dart';
import 'package:rxdart/subjects.dart';

class ActivitiesViewModel extends BaseViewModel {
  final activitiesHistoryList = BehaviorSubject<List<ActivitiesHistory>>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    activitiesHistoryList.close();
  }
}

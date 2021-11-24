import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dutstore/utils/Failure.dart';

class BaseViewModel extends FullLifeCycleController with FullLifeCycle {
  final isOffline = BehaviorSubject.seeded(false);
  final isLoading = BehaviorSubject.seeded(false);
  final appError = BehaviorSubject<Failure>();
  final nextScreen = BehaviorSubject<String>();
  late StreamSubscription _connectivityState;

  @override
  void onInit() {
    super.onInit();
    _connectivityState = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      isOffline.add(result == ConnectivityResult.none);
    });
  }

  @override
  void onClose() {
    _connectivityState.cancel();
    isOffline.close();
    isLoading.close();
    appError.close();
    nextScreen.close();
    super.onClose();
  }
 
  @override
  void onDetached() {}

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

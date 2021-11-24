import 'package:dutstore/base/BaseViewModel.dart';
import 'package:dutstore/scences/PlaceOrderScreen/PlaceOrderViewModel.dart';
import 'package:dutstore/scences/RootView/RootViewModel.dart';
import 'package:dutstore/services/Network/MapService.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:tuple/tuple.dart';

class SelectLocationViewModel extends BaseViewModel {
  final GoogleMapService _mapService = Get.find();
  final RootViewModel _rootViewModel = Get.find();
  final PlaceOrderViewModel _placeOrderViewModel = Get.find();
  late GoogleMapController googleMapController;

  final cameraPosition = CameraPosition(target: LatLng(0, 0));
  final position = BehaviorSubject<Tuple2<double, double>>();
  final destination = BehaviorSubject<Marker>();
  final address = BehaviorSubject<String>();
  final location = BehaviorSubject<void>();
  final isLoadingLocation = BehaviorSubject<bool>.seeded(false);
  final selectAddress = BehaviorSubject<void>();

  @override
  void onInit() {
    super.onInit();
    gps();
    position.listen((value) {
      isLoadingLocation.add(true);
      _mapService
          .addressFromLocation(value)
          .then((value) => address.add(value));

      destination.add(Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(value.item1, value.item2),
      ));
      animateCamera(value);
      isLoadingLocation.add(false);
    });
    location.listen((value) {
      gps();
    });
    selectAddress.listen((value) {
      _placeOrderViewModel.userAddress.add(address.valueWrapper?.value ?? "");
      Get.back();
    });
  }

  void animateCamera(Tuple2<double, double> position) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.item1, position.item2),
          zoom: 15,
        ),
      ),
    );
  }

  void gps() {
    isLoadingLocation.add(true);
    _mapService
        .determinePosition()
        .then(
          (pos) => position.add(Tuple2(pos.latitude, pos.longitude)),
        )
        .catchError((error, _) {
      _rootViewModel.showError(error);
    }).whenComplete(
      () => isLoadingLocation.add(false),
    );
  }

  @override
  void onClose() {
    super.onClose();
    position.close();
    destination.close();
    address.close();
    location.close();
    isLoadingLocation.close();
    selectAddress.close();
  }
}

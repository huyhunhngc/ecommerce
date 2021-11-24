import 'package:dio/dio.dart';
import 'package:dutstore/utils/Failure.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapService {
  final Dio dio = Dio();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(Failure('Location services are disabled.'));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(Failure('Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(Failure(
          'Location permissions are permanently denied, we cannot request permissions.'));
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> addressFromLocation(Tuple2<double, double> location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.item1, location.item2);
    Placemark placemark = placemarks.first;
    List<String> address = [];
    if (placemark.street?.isNotEmpty ?? false) address.add(placemark.street!);
    if (placemark.locality?.isNotEmpty ?? false)
      address.add(placemark.locality!);
    if (placemark.subAdministrativeArea?.isNotEmpty ?? false)
      address.add(placemark.subAdministrativeArea!);
    if (placemark.administrativeArea?.isNotEmpty ?? false)
      address.add(placemark.administrativeArea!);
    if (placemark.country?.isNotEmpty ?? false) address.add(placemark.country!);
    return address.join(', ');
  }
}

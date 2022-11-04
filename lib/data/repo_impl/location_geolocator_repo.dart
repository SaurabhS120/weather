import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/location_repo.dart';

class LocationGeolocatorRepo extends LocationRepo {
  @override
  Future<LocationModel> getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are denined forever ");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var positionEntity = LocationModel(position.latitude, position.longitude);
    print(
        'location lat : ${positionEntity.lattitude}, location lon : ${positionEntity.longitude}');
    return Future.value(positionEntity);
  }
}

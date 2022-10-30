import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather/data/repo_impl/location_geolocator_repo.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';

class GeoLocationController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxString _location = ''.obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getLattitude() => _lattitude;

  RxDouble getLongitude() => _longitude;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  LocationRepo locationRepo = LocationGeolocatorRepo();

  void getLocation() async {
    LocationEntity location = await locationRepo.getLocation();
    _longitude.value = location.longitude;
    _lattitude.value = location.lattitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.lattitude, location.longitude);
    Placemark place = placemarks[0];
    print(place.locality);
    _location.value = place.locality!;
    _isLoading.value = false;
  }

  RxString getAddress() {
    return _location;
  }
}

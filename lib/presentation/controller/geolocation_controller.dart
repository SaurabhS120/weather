import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather/data/repo_impl/location_geolocator_repo.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';

class GeoLocationController extends GetxController {
  final RxBool _isLoading = false.obs;
  final _location = Rx<LocationEntity?>(null);
  final RxString _city = ''.obs;

  RxBool checkLoading() => _isLoading;

  Rx<LocationEntity?> getLocationEntity() => _location;

  LocationRepo locationRepo = LocationGeolocatorRepo();

  void getLocation() async {
    _isLoading.value = true;
    LocationEntity location = await locationRepo.getLocation();
    _location.value = LocationEntity(location.lattitude, location.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.lattitude, location.longitude);
    Placemark place = placemarks[0];
    print(place.locality);
    _city.value = place.locality!;
    _isLoading.value = false;
  }

  RxString getCity() {
    return _city;
  }
}

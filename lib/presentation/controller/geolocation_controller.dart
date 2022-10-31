import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather/data/repo_impl/city_name_to_lat_lon_geo_loc_repo_impl.dart';
import 'package:weather/data/repo_impl/location_geolocator_repo.dart';
import 'package:weather/domain/entity/location_entity.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:weather/domain/usecase/LocationFromCityUsecase.dart';

class GeoLocationController extends GetxController {
  final loc_from_city_name_usecase =
      LocationFromCityUsecase(CiityNameToLatLonGeoLocRepoImpl());
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

  void getLocationFromCityName(String cityName, {Function? onFinish}) async {
    LocationEntity locationEntity =
        await loc_from_city_name_usecase.invoke(cityName);
    _location.value = locationEntity;
    _city.value = cityName;
    onFinish?.call();
  }
}

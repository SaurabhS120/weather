import 'package:get/get.dart';
import 'package:weather/data/repo_impl/location_geolocator_repo.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/location_model.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';

class GeoLocationController extends GetxController {
  final locFromCityNameUsecase = Get.find<LocationFromCityUsecase>();
  final latLongToCityNameUsecase = Get.find<LatLongToCityNameUsecase>();
  final RxBool _isLoading = false.obs;
  final _location = Rx<LocationModel?>(null);
  final RxString _city = ''.obs;

  RxBool checkLoading() => _isLoading;

  Rx<LocationModel?> getLocationEntity() => _location;

  LocationRepo locationRepo = LocationGeolocatorRepo();

  void getCurrentLocation() async {
    _isLoading.value = true;
    LocationModel location = await locationRepo.getLocation();
    _location.value = LocationModel(location.lattitude, location.longitude);
    String city_name = await latLongToCityNameUsecase.invoke(location);
    print(city_name);
    _city.value = city_name;
    _isLoading.value = false;
  }

  RxString getCity() {
    return _city;
  }

  void getLocationFromCityName(String cityName, {Function? onFinish}) async {
    LocationModel locationModel = await locFromCityNameUsecase.invoke(cityName);
    _location.value = locationModel;
    _city.value = cityName;
    onFinish?.call();
  }

  void setLocation(CityModel cityEntity) {
    _city.value = cityEntity.cityName;
    _location.value = cityEntity.locationModel;
  }
}

import 'package:get/get.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/location_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/location_item.dart';

class GeoLocationController extends GetxController {
  final locFromCityNameUsecase = Get.find<LocationFromCityUsecase>();
  final latLongToCityNameUsecase = Get.find<LatLongToCityNameUsecase>();
  final locationUseCase = Get.find<LocationUseCase>();
  final RxBool _isLoading = false.obs;
  final _location = Rx<LocationItem?>(null);
  final RxString _city = ''.obs;

  RxBool checkLoading() => _isLoading;

  Rx<LocationItem?> getLocationEntity() => _location;

  void getCurrentLocation() async {
    _isLoading.value = true;
    LocationItem location = await locationUseCase.invoke();
    _location.value = LocationItem(location.lattitude, location.longitude);
    String city_name = await latLongToCityNameUsecase.invoke(location);
    print(city_name);
    _city.value = city_name;
    _isLoading.value = false;
  }

  RxString getCity() {
    return _city;
  }

  void getLocationFromCityName(String cityName, {Function? onFinish}) async {
    LocationItem locationItem = await locFromCityNameUsecase.invoke(cityName);
    _location.value = locationItem;
    _city.value = cityName;
    onFinish?.call();
  }

  void setLocation(CityItem cityEntity) {
    _city.value = cityEntity.cityName;
    _location.value = cityEntity.locationItem;
  }
}

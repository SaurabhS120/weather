import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/location_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/location_item.dart';
import 'package:weather/presentation/notifiers/location_notifier.dart';

class GeoLocationController {
  final LocationFromCityUsecase locFromCityNameUsecase;
  final LatLongToCityNameUsecase latLongToCityNameUsecase;
  final LocationUseCase locationUseCase;
  LocationNotifier locationNotifier = LocationNotifier();

  GeoLocationController(this.locFromCityNameUsecase,
      this.latLongToCityNameUsecase, this.locationUseCase);

  void getCurrentLocation() async {
    LocationItem location = await locationUseCase.invoke();
    String cityName = await latLongToCityNameUsecase.invoke(location);
    print(cityName);
    setLocation(CityItem(cityName, location));
  }

  void getLocationFromCityName(String cityName, {Function? onFinish}) async {
    print('getLocationFromCityName : $cityName');
    LocationItem locationItem = await locFromCityNameUsecase.invoke(cityName);
    setLocation(CityItem(cityName, locationItem));
    onFinish?.call();
  }

  void setLocation(CityItem cityItem) {
    print('setLocation : ${cityItem.cityName}');
    locationNotifier.setLocation(cityItem);
  }
}

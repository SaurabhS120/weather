import 'package:flutter/material.dart';
import 'package:weather/di/binding/main_binding.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/location_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/location_item.dart';

class LocationNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool fetchingLocation = false;
  CityItem? city = null;
  String selectedCity = '';
  var choosingLoc = false;

  void selectCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void setChoosingLoc(bool choosing) {
    choosingLoc = choosing;
    notifyListeners();
  }

  void clear() {
    this.isLoading = false;
    this.city = null;
    notifyListeners();
  }

  void setLocation(CityItem city) {
    print('locationNotifier.setLocation : ${city.cityName}');
    this.isLoading = false;
    this.city = city;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    print('LocationNotifier.notifyListeners city : ${city?.cityName}');
    super.notifyListeners();
  }

  late LocationFromCityUsecase locationFromCityUsecase;
  late LatLongToCityNameUsecase latLongToCityNameUsecase;
  late LocationUseCase locationUseCase;

  LocationNotifier(MainBinding mainBinding) {
    this.locationFromCityUsecase = mainBinding.locationFromCityUsecase;
    this.latLongToCityNameUsecase = mainBinding.latLongToCityNameUsecase;
    this.locationUseCase = mainBinding.locationUseCase;
  }

  void getCurrentLocation() async {
    LocationItem location = await locationUseCase.invoke();
    String cityName = await latLongToCityNameUsecase.invoke(location);
    print(cityName);
    setLocation(CityItem(cityName, location));
  }

  void getLocationFromCityName(String cityName, {Function? onFinish}) async {
    print('getLocationFromCityName : $cityName');
    LocationItem locationItem = await locationFromCityUsecase.invoke(cityName);
    setLocation(CityItem(cityName, locationItem));
    onFinish?.call();
  }
}

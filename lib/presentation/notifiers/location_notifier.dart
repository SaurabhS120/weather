import 'package:flutter/material.dart';
import 'package:weather/presentation/item/city_item.dart';

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
}

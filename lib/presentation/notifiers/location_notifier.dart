import 'package:flutter/material.dart';
import 'package:weather/presentation/item/city_item.dart';

class LocationNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool fetchingLocation = false;
  CityItem? city = null;

  void clear() {
    this.isLoading = false;
    this.city = null;
    notifyListeners();
  }

  void setLocation(CityItem city) {
    this.isLoading = false;
    this.city = city;
    notifyListeners();
  }
}

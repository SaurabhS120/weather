import 'package:flutter/cupertino.dart';

class UiConfigNotifier extends ChangeNotifier {
  String currentCity = '';

  void setCurrentCity(String city) {
    this.currentCity = city;
    notifyListeners();
  }

  int current_page_no = 0;

  void changePage(int page_no) {
    current_page_no = page_no;
    notifyListeners();
  }
}

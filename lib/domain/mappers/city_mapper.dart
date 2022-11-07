import 'package:weather/domain/mappers/location_mapper.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/presentation/item/city_item.dart';

extension CityModelMapper on CityModel {
  CityItem toItem() {
    return CityItem(cityName, locationModel.toItem());
  }
}

extension CityItemMapper on CityItem {
  CityModel toModel() {
    return CityModel(cityName, locationItem.toModel());
  }
}

extension CityModelListMapper on List<CityModel> {
  List<CityItem> toItemList() {
    return map((e) => e.toItem()).toList();
  }
}

extension CityItemListMapper on List<CityItem> {
  List<CityModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}

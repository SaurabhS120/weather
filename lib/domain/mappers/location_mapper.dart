import 'package:weather/domain/model/location_model.dart';
import 'package:weather/presentation/item/location_item.dart';

extension LocationItemMapper on LocationItem {
  LocationModel toModel() => LocationModel(lattitude, longitude);
}

extension LocationModelMapper on LocationModel {
  LocationItem toItem() => LocationItem(lattitude, longitude);
}

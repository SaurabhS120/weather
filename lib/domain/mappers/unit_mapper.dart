import 'package:weather/domain/model/unit_model.dart';
import 'package:weather/presentation/item/unit_item.dart';

extension UnitModelMapper on UnitModel {
  UnitItem toItem() {
    if (unit is MetricUnitModel) {
      return UnitItem(MetricUnitItem());
    } else if (unit is ImperialUnitItem) {
      return UnitItem(ImperialUnitItem());
    } else {
      throw "Invalid unit type";
    }
  }
}

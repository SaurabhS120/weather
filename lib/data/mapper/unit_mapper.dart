import 'package:weather/data/entity/unit_entity.dart';
import 'package:weather/domain/model/unit_model.dart';

extension UnitEntityMapper on UnitEntity {
  UnitModel toModel() {
    if (unit == 'metric') {
      return UnitModel(MetricUnitModel());
    }
    if (unit == 'imperial') {
      return UnitModel(ImperialUnitModel());
    } else {
      throw "Unknown unit";
    }
  }
}

extension UnitModelMapper on UnitModel {
  UnitEntity toEntity() {
    return UnitEntity(unit.getUnitName());
  }
}

class UnitModel {
  UnitTypeModel unit;

  UnitModel(this.unit);
}

abstract class UnitTypeModel {
  String getUnitName();
}

class MetricUnitModel extends UnitTypeModel {
  @override
  String getUnitName() => "metric";
}

class ImperialUnitModel extends UnitTypeModel {
  @override
  String getUnitName() => "imperial";
}

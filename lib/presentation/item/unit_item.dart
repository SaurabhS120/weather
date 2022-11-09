class UnitItem {
  UnitTypeItem unit;

  UnitItem(this.unit);

  UnitItem toggle() {
    if (unit is MetricUnitItem) {
      return UnitItem(ImperialUnitItem());
    } else if (unit is ImperialUnitItem) {
      return UnitItem(MetricUnitItem());
    } else {
      throw 'Unknown unit';
    }
  }
}

abstract class UnitTypeItem {
  String getUnitName();

  String displayText();
}

class MetricUnitItem extends UnitTypeItem {
  @override
  String getUnitName() => "metric";

  @override
  String displayText() => '°F';
}

class ImperialUnitItem extends UnitTypeItem {
  @override
  String getUnitName() => "imperial";

  @override
  String displayText() => '°C';
}

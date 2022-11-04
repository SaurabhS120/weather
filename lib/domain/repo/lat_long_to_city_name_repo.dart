import 'package:weather/domain/model/location_model.dart';

abstract class LatLongToCityNameRepo {
  Future<String> getCityName(LocationModel location);
}

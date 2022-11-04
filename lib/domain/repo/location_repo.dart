import 'package:weather/domain/model/location_model.dart';

abstract class LocationRepo {
  Future<LocationModel> getLocation();
}

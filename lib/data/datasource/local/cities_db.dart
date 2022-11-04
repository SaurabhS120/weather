import 'package:sqflite/sqflite.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/location_model.dart';

class CitiesDB {
  Database? database;

  Future<Database?> init() async {
    if (database == null) {
      var databasesPath = await getDatabasesPath();
      String path = databasesPath + '/City.db';
      // open the database
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE City (id INTEGER PRIMARY KEY, name TEXT, latitude TEXT, longitude TEXT)');
      });
    }
    return database;
  }

  void addCity(CityModel city) async {
    var data = {
      'name': city.cityName,
      'latitude': city.locationModel.longitude,
      'longitude': city.locationModel.lattitude,
    };
    (await init())!.insert('City', data);
  }

  Future<List<CityModel>> getCities() async {
    var response = await (await init())!.rawQuery('SELECT * FROM City');
    return response
        .map((e) => CityModel(
            e['name'].toString(),
            LocationModel(double.parse(e['latitude'] as String),
                double.parse(e['longitude'] as String))))
        .toList();
  }

  void removeCity(String cityName) async {
    (await init())!.delete('City', where: "name=?", whereArgs: [cityName]);
  }
}

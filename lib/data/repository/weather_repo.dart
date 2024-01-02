import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/data/data_provider/location_provider.dart';
import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  final LocationProvider locationProvider;
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.locationProvider, this.weatherDataProvider);

  Future<Position?> getUserLocation() async {
    Position? position = await locationProvider.getLocation();
    return position;
  }

  Future<CurrentWeatherModel?> getCurrentWeather(num lat, num lon) async {
    Response res = await weatherDataProvider.getCurrentWeatherData(
        '$baseUrl$currentWeatherUrl?lat=$lat&lon=$lon&appid=$apiKey');
    var data = jsonDecode(res.body);
    return CurrentWeatherModel.fromJson(data);
  }
}

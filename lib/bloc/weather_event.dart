part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

final class GetLocation extends WeatherEvent {}

final class GetWeatherData extends WeatherEvent {
  final num lat;
  final num lon;
  GetWeatherData(this.lat, this.lon);
}

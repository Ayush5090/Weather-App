part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class LoadingState extends WeatherState {}

class WeatherDataLoadedState extends WeatherState {
  final CurrentWeatherModel currentWeatherData;
  WeatherDataLoadedState(this.currentWeatherData);
}

class LocationState extends WeatherState {
  final Position userPosition;
  LocationState(this.userPosition);
}

class ErrorState extends WeatherState {
  final String error;
  ErrorState(this.error);
}

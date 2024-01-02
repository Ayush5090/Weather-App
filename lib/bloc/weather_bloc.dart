import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/repository/weather_repo.dart';
import 'package:weather_app/model/weather_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<GetLocation>(_getLocationEvent);
    on<GetWeatherData>(_getWeatherData);
  }
  void _getLocationEvent(GetLocation event, Emitter<WeatherState> emit) async {
    emit(LoadingState());
    try {
      Position? position = await weatherRepository.getUserLocation();
      if (position != null) {
        emit(LocationState(position));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void _getWeatherData(GetWeatherData event, Emitter<WeatherState> emit) async {
    try {
      CurrentWeatherModel? currentWeather =
          await weatherRepository.getCurrentWeather(event.lat, event.lon);
      if (currentWeather != null) {
        emit(WeatherDataLoadedState(currentWeather));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

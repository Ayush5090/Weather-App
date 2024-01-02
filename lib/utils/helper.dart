import 'package:intl/intl.dart';
import 'package:weather_app/res/assets/assets.dart';

class HelperFunctions {
  static String formatDate(int timestamp) {
    int milliseconds = timestamp * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String month = getMonth(dateTime.month).substring(0, 3);
    String formattedDate = '${dateTime.day} $month';
    return formattedDate;
  }

  static String formatTime(int timestamp) {
    int milliseconds = timestamp * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  static String kelvinToCelsius(num tem) {
    num temInCelsius = tem - 273.15;
    return '${temInCelsius.toStringAsFixed(1)}° C';
  }

  static String windSpeedToKm(num speed) {
    num speedInKm = speed * 3600 / 1000;
    return '${speedInKm.toStringAsFixed(1)}/km';
  }

  static String getIconUrl(String id) {
    String iconUrl = 'https://openweathermap.org/img/wn/$id@2x.png';
    return iconUrl;
  }

  static String getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
    return '';
  }

  static String getWeatherSticker(int id) {
    switch (id) {
      case >= 200 && < 300:
        return AppAssets.thunderstorm;
      case >= 300 && < 400 || >= 500 && < 600:
        return AppAssets.rain;
      case >= 600 && < 700:
        return AppAssets.snowing;
      case >= 700 && < 800:
        return AppAssets.atmosphere;
      case == 800:
        return AppAssets.sun;
      case > 800 && < 900:
        return AppAssets.clouds;
    }
    return '';
  }
}

import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<http.Response> getCurrentWeatherData(String url) async {
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return res;
      } else {
        throw 'An unexpected error occurred';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

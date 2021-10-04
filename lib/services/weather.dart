import 'location.dart';
import 'networking.dart';

class WeatherModel {
  final LocationInfo loc = LocationInfo();
  double? longitude;
  double? latitude;
  static const apiKey = '8338a4d9e34faf23cc109c3115c01249';

  Future<dynamic> getLoc() async {
    await loc.getLocation();
    longitude = loc.long;
    latitude = loc.lat;
    Uri url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      "lat": "$latitude",
      "lon": "$longitude",
      "units": "metric",
      "appid": "$apiKey"
    });
    Networking networking = Networking(url);
    var weatherData = await networking.getWeatherData();

    return weatherData;
  }

  Future<dynamic> getCity(String? cityName) async {
    await loc.getLocation();
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    Uri url = Uri.https("api.openweathermap.org", "/data/2.5/weather",
        {"q": "$cityName", "appid": "$apiKey", "units": "metric"});
    Networking networking = Networking(url);
    var weatherData = await networking.getWeatherData();
    print(url);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

import '../services/location.dart';
import '../services/networking.dart';

class Weather {
  static const kAppId = 'ab0550e03a70ca808a6c5df74e22b7b1';
  static const kWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';
  static Location location = Location();
  final int _condition;
  final double _temperature;
  final String _locationName;

  const Weather(
      {required int condition,
      required double temperature,
      required String name})
      : _locationName = name,
        _temperature = temperature,
        _condition = condition;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      temperature: json['main']['temp'],
      condition: json['weather'][0]['id'],
    );
  }
  static Future<Weather> getLocationWeather() async {
    await location.getCurrentLocation();
    dynamic weatherData = await NetworkHelper.fetch(
        url:
            '$kWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kAppId&units=metric');
    Weather weather = Weather.fromJson(weatherData);
    return weather;
  }

  String getTemperature() => _temperature.toStringAsFixed(1);
  String getWeatherIcon() {
    if (_condition < 300) {
      return '🌩';
    } else if (_condition < 400) {
      return '🌧';
    } else if (_condition < 600) {
      return '☔️';
    } else if (_condition < 700) {
      return '☃️';
    } else if (_condition < 800) {
      return '🌫';
    } else if (_condition == 800) {
      return '☀️';
    } else if (_condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (_temperature > 25) {
      return 'It\'s 🍦 time in $_locationName';
    } else if (_temperature > 20) {
      return 'Time for shorts and 👕 in $_locationName';
    } else if (_temperature < 10) {
      return 'You\'ll need 🧣 and 🧤 in $_locationName';
    } else {
      return 'Bring a 🧥 just in case in $_locationName';
    }
  }
}

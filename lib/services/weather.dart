import '../services/location.dart';
import '../services/networking.dart';

class Weather {
  static const kAppId = 'ab0550e03a70ca808a6c5df74e22b7b1';
  static const kWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';
  static Location location = Location();
  final int condition;
  final double temp;
  final String name;

  const Weather(
      {required this.condition, required this.temp, required this.name});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      temp: json['main']['temp'],
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

  String getTemperature() => temp.toStringAsFixed(1);
  String getWeatherIcon() {
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

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time in $name';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in $name';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in $name';
    } else {
      return 'Bring a 🧥 just in case in $name';
    }
  }
}

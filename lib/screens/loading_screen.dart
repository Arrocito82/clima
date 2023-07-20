import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';

import '../services/location.dart';
import '../services/networking.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Location location;
  final appid = 'ab0550e03a70ca808a6c5df74e22b7b1';
  void getLocation() async {
    location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    weather = await NetworkHelper.fetch(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=${appid}&units=metric');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (buildContext) => LocationScreen(
                temp: weather.getTemperature(),
                description: weather.getMessage(),
                icon: weather.getWeatherIcon())));
  }

  late Weather weather;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "long: ${location.longitude} \nlat: ${location.latitude}")));
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}

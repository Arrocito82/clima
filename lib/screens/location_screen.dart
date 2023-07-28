import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weather});
  @override
  State<LocationScreen> createState() => _LocationScreenState();
  final Weather? weather;
}

class _LocationScreenState extends State<LocationScreen> {
  late String description, temperature, icon;
  @override
  void initState() {
    super.initState();
    updateWeather(widget.weather);
  }

  void updateWeather(Weather? weather) {
    if (weather == null) {
      setState(() {
        description = 'Failed to get weather';
        temperature = 'Error';
        icon = '⚠';
      });
      return;
    }
    setState(() {
      description = weather.getMessage();
      temperature = '${weather.getTemperature()}°';
      icon = weather.getWeatherIcon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Weather? updatedWeather;
                          try {
                            updatedWeather = await Weather.getLocationWeather();
                          } catch (e) {
                            updatedWeather = null;
                          }
                          updateWeather(updatedWeather);
                        },
                        child: const Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Weather? updatedWeather;
                          String? searchedCity = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (buildContext) => CityScreen()));
                          if (searchedCity != null) {
                            try {
                              updatedWeather =
                                  await Weather.getCityWeather(searchedCity);
                              updateWeather(updatedWeather);
                            } catch (e) {
                              updatedWeather = null;
                            }
                          }
                        },
                        child: const Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        temperature,
                        style: kTempTextStyle,
                      ),
                      Text(
                        icon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: "City Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade700,
                        letterSpacing: 2.5,
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      focusColor: Colors.white70,
                      icon: Icon(Icons.location_city),
                      iconColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorHeight: 25,
                    cursorColor: Colors.teal,
                    cursorWidth: 5,
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.5,
                      fontSize: 20,
                    ),
                    onChanged: (String searchedCity) {
                      city = searchedCity;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, city);
                  },
                  child: Text(
                    'Get Weather',
                    style: kButtonTextStyle,
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

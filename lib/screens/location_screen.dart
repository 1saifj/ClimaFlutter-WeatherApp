import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, required this.locWeather}) : super(key: key);

  final locWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String cityName;
  late int conditionID;
  late double temp;
  late String? typedName;
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    updateUI(widget.locWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    //TODO: use bloc here as state managment
    setState(() {
      temp = (weatherData['main']['temp']);
      conditionID = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weather.getLoc();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if (typedName != null) {
                        var weatherData = await weather.getCity(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${temp.toInt()}??',
                          style: kTempTextStyle,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${weather.getWeatherIcon(conditionID)}',
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      ' You are in ${cityName} City',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tourist_guide_california/models/Weather.dart';

import 'city_screen.dart';

class CityWeatherScreen extends StatefulWidget {
  CityWeatherScreen({this.weatherData});
  final weatherData;

  @override
  _CityWeatherScreenState createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  late int temprature;
  late String cityName;
  late String country;
  late String main;
  late double speed;
  late int humidity;
  late int pressure;
  var formattedDate;

  Weather weather = Weather();
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weather) {
    setState(() {
      temprature = weather['main']['temp'].toInt();
      humidity = weather['main']['humidity'].toInt();
      pressure = weather['main']['pressure'].toInt();
      speed = weather['wind']['speed'].toDouble();
      var condition = weather['weather'][0]['id'];
      main = weather['weather'][0]['description'];
      cityName = weather['name'];
      country = weather['sys']['country'];
      var timezone = weather['timezone'];
      var currDate = DateTime.now().toUtc().add(Duration(seconds: timezone));
      formattedDate = formatDate(
        currDate,
        [DD, ' | ', M, ' ', dd, ' | ', HH, ':', nn],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var currWeather =
                            await weather.getCurrentLocationData();
                        updateUI(currWeather);
                      },
                      child: Icon(
                        FlutterIcons.location_evi,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (cityName != null) {
                          var currWeatherData =
                              await weather.getCityWeather("Burbank");
                          print(currWeatherData);
                          updateUI(currWeatherData);
                        }
                      },
                      child: Icon(
                        FlutterIcons.search_evi,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$temprature°',
                        ),
                      ],
                    ),
                    Text(
                      main,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$cityName, $country',
                      ),
                      Text(
                        formattedDate,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              FlutterIcons.wind_fea,
                              size: 40.0,
                            ),
                            Icon(
                              FlutterIcons.md_speedometer_ion,
                              size: 40.0,
                            ),
                            Icon(
                              FlutterIcons.wi_humidity_wea,
                              size: 40.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${speed.toString()} m/s',
                            ),
                            Text(
                              '${pressure.toString()} Pa',
                            ),
                            Text(
                              '${humidity.toString()} g/m³',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

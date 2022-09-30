import 'package:flutter/material.dart';
import '../models/Weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'CityWeatherScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    Weather weatherModel = Weather();

    var weatherData = await weatherModel.getCityWeather("Burbank");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CityWeatherScreen(
          weatherData: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

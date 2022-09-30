import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

class Weather {
  // String temp_max;
  // String temp_min;
  // String humidity;
  // String weather;
  String apiKey = '5baf4d3d75d0493865be21ec71f9ad59';
  Weather();
  // Weather(this.temp_max, this.temp_min, this.humidity, this.weather);

  // factory Weather.fromMap(Map<String, dynamic> json) {
  //   return Weather(
  //       json['temp_max'], json['temp_min'], json['humidity'], json['weather']);
  // }
  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //       json['temp_max'], json['temp_min'], json['humidity'], json['weather']);
  // }

  Future<dynamic> getCityWeather(String s) async {
    try {
      var cityName = 'Burbank';
      final uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey'); // where we are going to connect: API address.

      //write coding here that is working.
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        //Something else to work.
        return jsonDecode(response.body);
        //Weather report = Weather.fromJson(response.body);
        //return report;
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<Weather> getCurrentLocationData() async {
    try {
      var cityName = 'Burbank';
      final uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey'); // where we are going to connect: API address.

      //write coding here that is working.
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        //Something else to work.
        print(response.body);
        return jsonDecode(response.body);
        //Weather report = Weather.fromJson(response.body);
        //return report;
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // Future<dynamic> getCityWeather(cityName) async {
  //   String url =
  //       'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';
  //   Network networkhelper = Network(url);
  //   var weatherData = await networkhelper.getData();
  //   return weatherData;
  // }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FlutterIcons.wi_thunderstorm_wea;
    } else if (condition < 400) {
      return FlutterIcons.wi_raindrops_wea;
    } else if (condition < 600) {
      return FlutterIcons.wi_rain_wea;
    } else if (condition < 700) {
      return FlutterIcons.wi_day_snow_wea;
    } else if (condition < 800) {
      return FlutterIcons.wi_fog_wea;
    } else if (condition == 800) {
      return FlutterIcons.wi_wu_clear_wea;
    } else if (condition <= 804) {
      return FlutterIcons.wi_cloud_wea;
    } else {
      return FlutterIcons.weather_night_mco;
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

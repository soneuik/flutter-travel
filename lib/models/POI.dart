import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Reference:
//foursquare that is API used by samsung, uber, and airbnb
//https://developer.foursquare.com/reference/place-search
//https://developer.foursquare.com/reference/places-nearby
class POI {
  // String temp_max;
  // String temp_min;
  // String humidity;
  // String weather;
  String apiKey = '5baf4d3d75d0493865be21ec71f9ad59';
  POI();
  // Weather(this.temp_max, this.temp_min, this.humidity, this.weather);

  // factory Weather.fromMap(Map<String, dynamic> json) {
  //   return Weather(
  //       json['temp_max'], json['temp_min'], json['humidity'], json['weather']);
  // }
  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //       json['temp_max'], json['temp_min'], json['humidity'], json['weather']);
  // }

//list
  // curl --request GET \
  //    --url 'https://api.foursquare.com/v3/places/search?ll=34.052239%2C-118.243398&sort=POPULARITY' \
  //    --header 'Authorization: fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=' \
  //    --header 'accept: application/json'
//get place pics
// curl --request GET \
//      --url https://api.foursquare.com/v3/places/4dbf1c816e810768bf9cee43/photos \
//      --header 'Authorization: fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=' \
//      --header 'accept: application/json'
  Future<dynamic> getCityPOI(String s) async {
    try {
      //Latitude: 34.052239 ; Longitude: -118.243398 of la
      var lan = '34.052239';
      var long = '-118.243398';
      var cityName = 'Los Angeles';
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
}

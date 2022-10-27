import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class City {
  final String city_name;
  final String latitude;
  final String longitude;

  const City(
      {required this.city_name,
      required this.latitude,
      required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return new City(
        city_name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}

class CityViewModel {
  late List<City> cities;

  Future loadCities() async {
    try {
      cities = <City>[];
      String jsonString = await rootBundle.loadString('../json/city.json');
      Map parsedJson = json.decode(jsonString);
      var CityJson = parsedJson['data'] as List;
      for (int i = 0; i < CityJson.length; i++) {
        cities.add(new City.fromJson(CityJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}

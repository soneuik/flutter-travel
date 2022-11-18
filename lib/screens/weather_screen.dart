import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:date_format/date_format.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'city_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<dynamic> getWeatherData() async {
    try {
      String apiKey = '5baf4d3d75d0493865be21ec71f9ad59';
      var cityName = 'Los Angeles';
      final uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey'); // where we are going to connect: API address.

      //write coding here that is working.
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        //return jsonDecode(response.body);
        List responseList = jsonDecode("[" + response.body + "]");
        //print(responseList[0]['results']);
        return responseList.map((data) => Weather.fromJson(data)).toList();
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Weather Page'),
          ),
          body: Column(children: [
            CityPage(),
            Center(
              child: FutureBuilder(
                future: getWeatherData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data as List<Weather>;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                                "temperature: " +
                                    items[index].temprature.toString() +
                                    '\n' +
                                    "speed: " +
                                    items[index].speed.toString() +
                                    '\n' +
                                    "humidity: " +
                                    items[index].humidity.toString() +
                                    '\n' +
                                    "cityName: " +
                                    items[index].cityName.toString() +
                                    '\n' +
                                    "date: " +
                                    items[index].formattedDate.toString() +
                                    '\n',
                                style: TextStyle(),
                                softWrap: true),
                          ));
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
          ])),
    );
  }
}

class Weather {
  late int temprature;
  late String cityName;
  late String country;
  late String main;
  late double speed;
  late int humidity;
  late int pressure;
  var formattedDate;

  Weather(
      {required this.temprature,
      required this.cityName,
      required this.country,
      required this.main,
      required this.speed,
      required this.humidity,
      required this.pressure,
      required this.formattedDate});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var timezone = json['timezone'];
    var currDate = DateTime.now().toUtc().add(Duration(seconds: timezone));
    return Weather(
        temprature: json['main']['temp'].toInt(),
        humidity: json['main']['humidity'].toInt(),
        pressure: json['main']['pressure'].toInt(),
        speed: json['wind']['speed'].toDouble(),
        main: json['weather'][0]['description'],
        cityName: json['name'],
        country: json['sys']['country'],
        formattedDate:
            formatDate(currDate, [DD, ' | ', M, ' ', dd, ' | ', HH, ':', nn]));
  }
}

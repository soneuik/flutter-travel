import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/Weather.dart';

const apiKey = '5baf4d3d75d0493865be21ec71f9ad59';

class GetWeatherApi {
  //how to connect to the API
  Future<Weather> fetchWeatherReport() async {
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
}

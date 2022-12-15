import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

//https://location.foursquare.com/developer/reference/address-details

class PoiDetail extends StatefulWidget {
  const PoiDetail(
      {Key? key,
      required this.title,
      required this.city,
      required this.poi_detail_key_fsq_id,
      required this.poi_name,
      required this.poi_address})
      : super(key: key);
  final String title;
  final String city;
  final String poi_detail_key_fsq_id;
  final String poi_name;
  final String poi_address;

  @override
  State<PoiDetail> createState() =>
      _PoiDetailState(city, poi_detail_key_fsq_id, poi_name, poi_address);
}

class _PoiDetailState extends State<PoiDetail> {
  String city = "";
  String poi_detail_key_fsq_id = "";
  String poi_name = "";
  String poi_address = "";
  String detailImageUrl = "";
  var lat = '34.052239';
  var long = '-118.243398';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  _PoiDetailState(
      this.city, this.poi_detail_key_fsq_id, this.poi_name, this.poi_address);

  Future<String> getPOIDetailImageUrl(var poi_detail_key_fsq_id) async {
    String apiKey = 'fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=';
    try {
      //34.052239,-118.243398
      //Latitude: 34.052239 ; Longitude: -118.243398 of la
      var cityName = 'Los Angeles';
      var poi_detail_key_fsq_id = this.poi_detail_key_fsq_id;
      print("poi_detail_key_fsq_id: " + poi_detail_key_fsq_id);
      final uri = Uri.parse(
          'https://api.foursquare.com/v3/places/$poi_detail_key_fsq_id/photos?limit=1&sort=POPULAR'); // where we are going to connect: API address.
      //    --header 'Authorization: fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=' \
      //    --header 'accept: application/json'
      final baseHeader = {
        HttpHeaders.authorizationHeader: apiKey,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      };
      //write coding here that is working.
      http.Response response = await http.get(uri, headers: baseHeader);
      if (response.statusCode == 200) {
        //Something else to work.
        List responseList = jsonDecode(response.body);
        //print(responseList[0]['results']);
        var prefix = responseList[0]['prefix'];
        var suffix = responseList[0]['suffix'];
        detailImageUrl = "$prefix" + "500x400" + "$suffix";
        print("detailImageUrl: " + detailImageUrl);
        return detailImageUrl;
        //Weather report = Weather.fromJson(response.body);
        //return report;
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<dynamic> getWeatherData() async {
    try {
      String apiKey = '5baf4d3d75d0493865be21ec71f9ad59';
      var cityName = city;
      final uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey'); // where we are going to connect: API address.

      //write coding here that is working.
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        //return jsonDecode(response.body);
        List responseList = jsonDecode("[" + response.body + "]");
        print('weather:');
        print(responseList);
        return responseList.map((data) => Weather.fromJson(data)).toList();
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<POIDetail?> getPOIDetaildata(var poi_detail_key_fsq_id) async {
    String apiKey = 'fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=';
    try {
      //34.052239,-118.243398
      //Latitude: 34.052239 ; Longitude: -118.243398 of la
      var lat = '34.052239';
      var long = '-118.243398';
      var cityName = 'Los Angeles';
      var poi_detail_key_fsq_id = this.poi_detail_key_fsq_id;
      print("poi_detail_key_fsq_id: " + poi_detail_key_fsq_id);
      final uri = Uri.parse(
          'https://api.foursquare.com/v3/places/$poi_detail_key_fsq_id/photos?limit=1&sort=POPULAR'); // where we are going to connect: API address.
      //    --header 'Authorization: fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=' \
      //    --header 'accept: application/json'
      final baseHeader = {
        HttpHeaders.authorizationHeader: apiKey,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      };
      //write coding here that is working.
      http.Response response = await http.get(uri, headers: baseHeader);
      if (response.statusCode == 200) {
        //Something else to work.
        List responseList = jsonDecode(response.body);
        //print(responseList[0]['results']);
        print("detailImageUrl: " + detailImageUrl);
        return null;

        //Weather report = Weather.fromJson(response.body);
        //return report;
      } else {
        throw 'Somthing went wrong';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    //getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: FutureBuilder(
                            future: getWeatherData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var items = snapshot.data as List<Weather>;

                                return (Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Weather: ${items[0].weather}',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Color(0xFF101213),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Temperature: ${items[0].temprature} °F',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Color(0xFF101213),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'pressure: ${items[0].pressure} mmhg',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Color(0xFF101213),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Humidity: ${items[0].humidity}%',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Color(0xFF101213),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Wind: ${items[0].speed} mph',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Color(0xFF101213),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ));
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          )),
                        ],
                      ),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FutureBuilder(
                          future: getPOIDetailImageUrl(poi_detail_key_fsq_id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var detailImageUrl = snapshot.data as String;
                              print("detailImageUrl3: " + detailImageUrl);
                              return Image.network(
                                detailImageUrl,
                                width: 500,
                                height: 300,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Text(
                              poi_name,
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Color(0xFF101213),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Text(
                              poi_address,
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Color(0xFF57636C),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF11E9B9),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Text(
                                'TIPs',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Text(
                                    'Goo place to visit if it is first time ',
                                    maxLines: 1,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      color: Color(0xFF101213),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Text(
                                    'look nicer than I expected',
                                    maxLines: 1,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      color: Color(0xFF101213),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Text(
                                    'Hello World',
                                    maxLines: 1,
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      color: Color(0xFF101213),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class POIDetail {
  String poi_name = "";
  String poi_address = "";
  String poi_detail_key_fsq_id = "";

  POIDetail(
      {required this.poi_name,
      required this.poi_address,
      required this.poi_detail_key_fsq_id});

  //https://docs.flutter.dev/development/data-and-backend/json
  //  Map<String, dynamic> data = jsonDecode(response.body);
  //  String token = data["data"]["access_token"];
  factory POIDetail.fromJson(Map<String, dynamic> json) {
    return POIDetail(
        poi_name: json['name'],
        poi_address: json['location']['formatted_address'],
        poi_detail_key_fsq_id: json['fsq_id']);
  }
}

class Weather {
  late String temprature;
  late String cityName;
  late String country;
  late String main;
  late String speed;
  late String humidity;
  late String pressure;
  late String weather;

  Weather(
      {required this.temprature,
      required this.cityName,
      required this.country,
      required this.main,
      required this.speed,
      required this.humidity,
      required this.pressure,
      required this.weather});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temprature: json['main']['temp'].toString(),
        humidity: json['main']['humidity'].toString(),
        pressure: json['main']['pressure'].toString(),
        speed: json['wind']['speed'].toString(),
        main: json['weather'][0]['description'].toString(),
        cityName: json['name'].toString(),
        country: json['sys']['country'].toString(),
        weather: json['weather'][0]['main'].toString());
  }
}

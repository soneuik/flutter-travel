import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';

class POILIST extends StatefulWidget {
  const POILIST({Key? key}) : super(key: key);

  @override
  State<POILIST> createState() => _POILISTState();
}

class _POILISTState extends State<POILIST> {
  Future<List<POI>> getPOIdata() async {
    String apiKey = 'fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=';
    try {
      //34.052239,-118.243398
      //Latitude: 34.052239 ; Longitude: -118.243398 of la
      var lat = '34.052239';
      var long = '-118.243398';
      var cityName = 'Los Angeles';
      final uri = Uri.parse(
          'https://api.foursquare.com/v3/places/search?ll=$lat%2C$long&sort=POPULARITY'); // where we are going to connect: API address.
      //    --header 'Authorization: fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=' \
      //    --header 'accept: application/json'
      final baseHeader = {
        HttpHeaders.authorizationHeader: '$apiKey',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      };
      //write coding here that is working.
      http.Response response = await http.get(uri, headers: baseHeader);
      if (response.statusCode == 200) {
        //Something else to work.
        List responseList = jsonDecode("[" + response.body + "]");
        responseList = responseList[0]['results'];
        //print(responseList[0]['results']);
        return responseList.map((data) => POI.fromJson(data)).toList();

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: getPOIdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data as List<POI>;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      //show POI list data
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xE7747BF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Text(
                                      items[index].poi_name,
                                      maxLines: 1,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Text(
                                      items[index].poi_address,
                                      maxLines: 1,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class POI {
  String poi_name = "";
  String poi_address = "";

  POI({required this.poi_name, required this.poi_address});

  //https://docs.flutter.dev/development/data-and-backend/json
  //  Map<String, dynamic> data = jsonDecode(response.body);
  //  String token = data["data"]["access_token"];
  factory POI.fromJson(Map<String, dynamic> json) {
    return POI(
        poi_name: json['name'],
        poi_address: json['location']['formatted_address']);
  }
}


//list builder
//https://kodestat.gitbook.io/flutter/flutter-listview-with-json-or-list-data
//https://github.com/YoncaYeprem/Horoscopes-App/blob/master/lib/models/horoscope.dart
 

 
 

 //TO put two API data together in one page
 //https://stackoverflow.com/questions/51666034/flutter-is-it-possbile-to-have-multiple-futurebuilder-or-a-futurebuilder-for-mu
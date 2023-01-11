import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'poi_detail.dart';

class POILIST extends StatefulWidget {
  const POILIST({Key? key}) : super(key: key);

  @override
  State<POILIST> createState() => _POILISTState();
}

class _POILISTState extends State<POILIST> {
  static String onSelectedCity = "Los Angeles";
  static String onSelectedLat = '34.052239';
  static String onSelectedLong = '-118.243398';
  List<PoiDetail> poi_detail_list = [];
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();

  late AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();

  late MapController _mapController;

  void _loadData() async {
    await CitiesViewModel.loadCities1();
  }

  void moveMapCenter(double lan, double long) {
    _mapController.move(LatLng(lan, long), 10.0);
  }

  @override
  void initState() {
    _loadData();
    _mapController = MapController();

    print(poi_detail_list);
    super.initState();
  }

  static Future<List<POI>> getPOIdata(String city) async {
    String apiKey = 'fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=';
    try {
      //34.052239,-118.243398
      //Latitude: 34.052239 ; Longitude: -118.243398 of la
      var lat = '34.052239';
      var long = '-118.243398';
      var cityName = city;
      print("cityName: " + cityName);
      print("onSelectedLat: " + onSelectedLat);
      print("onSelectedLong: " + onSelectedLong);
      final uri = Uri.parse(
          'https://api.foursquare.com/v3/places/search?ll=$onSelectedLat%2C$onSelectedLong&sort=POPULARITY'); // where we are going to connect: API address.
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
        List responseList = jsonDecode("[" + response.body + "]");
        //print(responseList[0]['results']);
        responseList = responseList[0]['results'];
        print(responseList);
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
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Column(
        children: [
          //autocomplete searchbar
          Center(
              child: Column(children: <Widget>[
            Column(children: <Widget>[
              searchTextField = AutoCompleteTextField<City>(
                  style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  decoration: InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: 'Search City Name',
                      hintStyle: const TextStyle(color: Colors.black)),
                  itemSubmitted: (item) {
                    setState(() => searchTextField.textField!.controller?.text =
                        item.cityName);
                    onSelectedCity = item.cityName;
                    onSelectedLat = item.latitude;
                    onSelectedLong = item.longitude;
                    moveMapCenter(double.parse(onSelectedLat),
                        double.parse(onSelectedLong));
                  },
                  clearOnSubmit: false,
                  //GlobalKey<AutoCompleteTextFieldState<T>>:is required to enable adding suggestions to the textfield
                  //and also the clear() method can be called to clear AutoCompleteTextField, if required.
                  key: key,
                  //suggestions: This will enable the suggestions that are going to be displayed in UI
                  suggestions: CitiesViewModel.cities, // data list
                  // itemBuilder: This is a callback to build each item in the list that is going to be displayed containing suggested data and returns a widget.
                  //the suggested list based on inputs entered by users.
                  itemBuilder: (context, item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.cityName,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        Text(
                          item.cityName,
                        )
                      ],
                    );
                  },
                  //itemSorter: This is a callback to sort items.
                  itemSorter: (a, b) {
                    return a.cityName.compareTo(b.cityName);
                  },
                  // itemFilter: This is a callback to filter item and
                  // returns true or false depending on input text.
                  itemFilter: (item, query) {
                    return item.cityName
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  }),
            ]),
          ])),

          //FlutterMap:START
          Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment
                  .center, //Center Column contents horizontally,
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder(
                  future: getPOIdata(onSelectedCity),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var items = snapshot.data as List<POI>;
                      final markers = <Marker>[];
                      for (var i = 0; i < items.length; i++) {
                        POI currrentPoi = items[i];
                        double lat = currrentPoi.lat;
                        double long = currrentPoi.long;
                        markers.add(Marker(
                          width: 80,
                          height: 80,
                          point: LatLng(lat, long),
                          builder: (ctx) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PoiDetail(
                                    title: 'Poi_detail',
                                    city: onSelectedCity,
                                    poi_detail_key_fsq_id:
                                        items[i].poi_detail_key_fsq_id,
                                    poi_name: items[i].poi_name,
                                    poi_address: items[i].poi_address,
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.pin_drop),
                          ),
                        ));
                      }
                      return Flexible(
                          child: SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: Flexible(
                                  child: FlutterMap(
                                      mapController: _mapController,
                                      options: MapOptions(
                                          center: LatLng(
                                              double.parse(onSelectedLat),
                                              double.parse(onSelectedLong)),
                                          zoom: 10),
                                      children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName:
                                          'dev.fleaflet.flutter_map.example',
                                    ),
                                    MarkerLayer(markers: markers),
                                  ]))));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return const Text("LOADING MAP...");
                  },
                )
              ]),
          //FlutterMap:END

          //POILIST:START
          Expanded(
            child: FutureBuilder(
              future: getPOIdata(onSelectedCity),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var items = snapshot.data as List<POI>;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        //show POI list data
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PoiDetail(
                                  title: 'Poi_detail',
                                  city: onSelectedCity,
                                  poi_detail_key_fsq_id:
                                      items[index].poi_detail_key_fsq_id,
                                  poi_name: items[index].poi_name,
                                  poi_address: items[index].poi_address,
                                ),
                              ),
                            );
                          },
                          //Card UI
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xE7747BF2),
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 5, 5, 5),
                                        child: Text(
                                          items[index].poi_name,
                                          maxLines: 1,
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            color: Color.fromARGB(
                                                255, 233, 244, 80),
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 5, 5, 5),
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
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return const Text("LOADING LIST...");
              },
            ),
          ),
        ],
      )),
    );
  }
}

class POI {
  String poi_name = "";
  String poi_address = "";
  String poi_detail_key_fsq_id = "";
  double lat = 0;
  double long = 0;
  POI(
      {required this.poi_name,
      required this.poi_address,
      required this.poi_detail_key_fsq_id,
      required this.lat,
      required this.long});

  //https://docs.flutter.dev/development/data-and-backend/json
  //  Map<String, dynamic> data = jsonDecode(response.body);
  //  String token = data["data"]["access_token"];
  factory POI.fromJson(Map<String, dynamic> json) {
    return POI(
      poi_name: json['name'],
      poi_address: json['location']['formatted_address'],
      poi_detail_key_fsq_id: json['fsq_id'],
      lat: json['geocodes']['main']['latitude'],
      long: json['geocodes']['main']['longitude'],
    );
  }
}

//It is used to declare static List of City class and add the decoded json data in it
class CitiesViewModel {
  static List<City> cities = <City>[];

  static Future loadCities1() async {
    try {
      cities = <City>[];
      String jsonString = await rootBundle.loadString('lib/json/city.json');
      List parsedJson = jsonDecode(jsonString);
      for (int i = 0; i < parsedJson.length; i++) {
        cities.add(City.fromJson(parsedJson[i]));
      }
      print(cities);
    } catch (e) {
      print(e);
    }
  }

  static Future loadCities() async {
    try {
      String jsonString = await rootBundle.loadString('lib/json/city.json');
      List responseList = jsonDecode(jsonString);
      cities = responseList.map((data) => City.fromJson(data)).toList();
    } catch (e) {
      print(e);
      throw 'Somthing went wrong';
    }
  }
}

//City class is used when json is parsed and decide required data from .json file
class City {
  final String cityName;
  final String latitude;
  final String longitude;

  const City(
      {required this.cityName,
      required this.latitude,
      required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        cityName: json['city'].toString(),
        latitude: json['latitude'].toString(),
        longitude: json['longitude'].toString());
  }
}

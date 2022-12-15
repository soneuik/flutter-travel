import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PoiDetail extends StatefulWidget {
  const PoiDetail(
      {Key? key,
      required this.tile,
      required this.poi_detail_key_fsq_id,
      required this.poi_name,
      required this.poi_address})
      : super(key: key);

  final String tile;
  final String poi_detail_key_fsq_id;
  final String poi_name;
  final String poi_address;

  @override
  State<StatefulWidget> createState() =>
      _PoiDetailState(poi_detail_key_fsq_id, poi_name, poi_address);
}

class _PoiDetailState extends State<PoiDetail> {
  //Variables.
  String poi_detail_key_fsq_id = "";
  String poi_name = "";
  String poi_address = "";
  String detailImageUrl = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Constructor.
  _PoiDetailState(
      String poi_detail_key_fsq_id, String poi_name, String poi_address);

  //Functions to get data from API.
  //This function is to get actual url of image of POI(Point of Interest)
  Future<String> getPOIDetailImageUrl(var poi_detail_key_fsq_id) async {
    String apiKey = "fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=";
    try {
      var lat = '';
      var long = '';
      var cityName = 'Los Angeles';
      var poi_detail_key_fsq_id = this.poi_detail_key_fsq_id;
      final uri = Uri.parse(
          'https://api.foursquare.com/v3/places/$poi_detail_key_fsq_id/photos?limit=1&sort=POPULAR');

      final baseHeader = {
        HttpHeaders.authorizationHeader: apiKey,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      };
      http.Response response = await http.get(uri, headers: baseHeader);
      if (response.statusCode == 200) {
        List responseList = jsonDecode(response.body);
        var prefix = responseList[0]['prefix'];
        var suffix = responseList[0]['suffix'];
        detailImageUrl = "$prefix" + "500x400" + "$suffix";
        return detailImageUrl;
      } else {
        throw 'Not successful to get data from API';
      }
    } catch (error) {
      throw 'Something went wrong';
    }
  }

  Future<POIDetail?> getPOIDetaildata(var poi_detail_key_fsq_id) async {
    String apiKey = "fsq33Lsqz7rG2M8eRkSMm8kFXFQKo6EZ6ecw4ei5/ZD2Xf0=";
    try {} catch (error) {
      throw 'Something went wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF5282D5),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Hollywood Sign',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Color(0xFF101213),
                            fontWeight: FontWeight.w600,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Los Angeles, CA 90068',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Color(0xFF101213),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weather: Sunny',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Temperature: 58 °F',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Precipitation: 2%',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Humidity: 84%',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Wind: 2 mph',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://miro.medium.com/max/1105/1*Y_vMmEe7bmOlVgLDC8QE8w.jpeg',
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                fit: BoxFit.cover,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                            child: Text(
                              'Reviews:',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Color(0xFF101213),
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Text(
                                'Example Comments1',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Example Comments2',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Example Comments3',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Example Comments4',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Example Comments6',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF101213),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
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

  factory POIDetail.fromJson(Map<String, dynamic> json) {
    return POIDetail(
        poi_name: json['name'],
        poi_address: json['location']['formatted_address'],
        poi_detail_key_fsq_id: json['fsq_id']);
  }
}

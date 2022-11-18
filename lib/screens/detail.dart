import 'package:flutterflow_ui/flutterflow_ui.dart';
// Remember to copy the import above and check for any dependencies in the pubspec view

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaygroundPageWidget extends StatefulWidget {
  const PlaygroundPageWidget({Key? key}) : super(key: key);

  @override
  _PlaygroundPageWidgetState createState() => _PlaygroundPageWidgetState();
}

class _PlaygroundPageWidgetState extends State<PlaygroundPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                          Text(
                            'Temperature: 76°F',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Color(0xFF101213),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Precipitation: 0%',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Color(0xFF101213),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Humidity: 23%',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Color(0xFF101213),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Wind: 9 mph',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Color(0xFF101213),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://picsum.photos/seed/508/600',
                        width: 500,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Text(
                              'Hollywood Sign',
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
                              'Historical landmark in Los Angeles, California',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
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

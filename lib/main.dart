import 'package:flutter/material.dart';
import 'package:tourist_guide_california/screens/cardview.dart';
import 'screens/autocomplete.dart';
import 'screens/city_screen.dart';
import 'screens/poi_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: POILIST(),
    );
  }
}

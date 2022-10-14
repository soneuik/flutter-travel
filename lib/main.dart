import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';
import 'screens/poi_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: POILIST(),
    );
  }
}

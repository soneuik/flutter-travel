import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = "Burbank";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather2-01.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FlutterIcons.arrow_left_sli,
                    size: 35.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.grey,
                    primaryColorDark: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      cityName = value;
                    },
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Quicksand',
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        icon: Icon(
                          FlutterIcons.search_evi,
                          color: Colors.white,
                        ),
                        fillColor: Color(0x29ffffff),
                        hintText: 'Enter City Name',
                        hintStyle: TextStyle(
                          color: Color(0x29fffffff),
                        )),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                color: Color(0x10000000),
                child: Text(
                  'Fetch Weather',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

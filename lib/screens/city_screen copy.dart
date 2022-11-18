import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

//reference: https://medium.com/flutter-community/implementing-auto-complete-search-list-a8dd192bd5f6

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

//It is used to declare static List of City class and add the decoded json data in it
class CitiesViewModel {
  static late List<City> cities;

  static Future loadCities1() async {
    try {
      String jsonString = await rootBundle.loadString('lib/json/city.json');
      List parsedJson = jsonDecode(jsonString);
      for (int i = 0; i < parsedJson.length; i++) {
        cities.add(City.fromJson(parsedJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }

  void loadCities() async {
    try {
      String jsonString = await rootBundle.loadString('lib/json/city.json');
      List responseList = jsonDecode(jsonString);
      cities = responseList.map((data) => City.fromJson(data)).toList();
      print(cities[1].cityName);
      // Map parsedJson = json.decode(jsonString);
      // var CityJson = parsedJson['data'] as List;
      // for (int i = 0; i < CityJson.length; i++) {
      //   cities.add(City.fromJson(CityJson[i]));
      // }
    } catch (e) {
      print(e);
      throw 'Somthing went wrong';
    }
  }
}

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();

  late AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  void _loadData() async {
    await CitiesViewModel.loadCities1();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Auto Complete List Demo'),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Column(children: <Widget>[
            searchTextField = AutoCompleteTextField<City>(
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
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
        ])));
  }
}

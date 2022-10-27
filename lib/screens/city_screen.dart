import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

//reference
//https://stackoverflow.com/questions/53534197/autocomplete-suggestion-and-search-using-json-data
//https://medium.com/flutter-community/implementing-auto-complete-search-list-a8dd192bd5f6

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  List<City> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<City>> key =
      GlobalKey<AutoCompleteTextFieldState<City>>();
  late AutoCompleteTextField<City>? textField;
  List<City> cities = <City>[];
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

  @override
  void initState() {
    super.initState();
    loadCities();
    print(cities);
  }

  @override
  Widget build(BuildContext context) {
    print(cities);
    textField = AutoCompleteTextField<City>(
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          hintText: "Search City",
        ),
        key: key,
        submitOnSuggestionTap: true,
        clearOnSubmit: true,
        suggestions: cities,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          currentText = item;
        },
        itemSubmitted: (item) {
          setState(() {
            currentText = item.cityName;
            added.add(item);
            currentText = "";
          });
        },
        itemBuilder: (context, item) {
          return Padding(
              padding: EdgeInsets.all(8.0), child: new Text(item.cityName));
        },
        itemSorter: (a, b) {
          return a.cityName.compareTo(b.cityName);
        },
        itemFilter: (item, query) {
          return item.cityName.toLowerCase().startsWith(query.toLowerCase());
        });

    Column searchBody = Column(children: [
      ListTile(
          title: textField,
          trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if (currentText != "") {
                    added.add(cities.firstWhere(
                        (i) => i.cityName.toLowerCase().contains(currentText)));
                    textField!.clear();
                    currentText = "";
                  }
                });
              }))
    ]);

    searchBody.children.addAll(added.map((item) {
      return ListTile(title: Text(item.cityName));
    }));

    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(child: searchBody),
      ),
    );
  }
}

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

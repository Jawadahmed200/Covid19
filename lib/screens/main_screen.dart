import 'package:covid_19/db/dbhelper.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String dbSelectedCountry = "";
  String selectedCountry = "pk";
  final dbhelp = DatabaseHelper.instannce;

  void checkCountry() {
    print(dbSelectedCountry);
    if (dbSelectedCountry != null &&
        dbSelectedCountry != " " &&
        dbSelectedCountry.isNotEmpty) {
      print("if condition");
      selectedCountry = dbSelectedCountry;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(iosCountryCode: selectedCountry.toLowerCase()),
        ),
      );
    } else {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    List<Placemark> p = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = p[0];
    selectedCountry = place.isoCountryCode;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(iosCountryCode: selectedCountry.toLowerCase()),
      ),
    );

    addCountry();
  }

  void getCountry() async {
    var country = await dbhelp.queryspec(1);
    print(country);
    country.forEach((c) {
      dbSelectedCountry = c['name'];
      //print(c);
    });
    checkCountry();
    //print(country);
  }

  void deleteCountry() async {
    var c = await dbhelp.deleterow(1);
    print(c);
  }

  void addCountry() async {
    Map<String, dynamic> dataToInsert = {
      DatabaseHelper.colname: selectedCountry,
    };
    await dbhelp.insert(dataToInsert);
  }

  @override
  void initState() {
    super.initState();
    //deleteCountry();
    getCountry();
    //getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4C79FF),
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

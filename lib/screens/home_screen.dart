import 'package:covid_19/screens/state_screen.dart';
import 'package:covid_19/screens/test_screen.dart';
import 'package:covid_19/widgets_utilities/covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:covid_19/widgets_utilities/bottom_button.dart';

class HomeScreen extends StatefulWidget {
  String iosCountryCode;
  HomeScreen({this.iosCountryCode});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSpinner = false;
  Covid covid = Covid();
  Country _selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            _header(),
            _preventions(),
            _banner(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      height: 50.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BottomButton(
            onPressed: () {},
            color: Color(0xFF4C79FF), //Color(0xFF4C79FF),
            icon: Icons.home,
            iconColor: Colors.white,
          ),
          BottomButton(
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });

              var covidGlobal = await covid.getGlobalData();
              var covidCountry =
                  await covid.getCountryData(widget.iosCountryCode);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StateScreen(
                    iosCountryCode: widget.iosCountryCode,
                    covidGlobalData: covidGlobal,
                    covidCountryData: covidCountry,
                  ),
                ),
              );
              setState(() {
                showSpinner = false;
              });
            },
            color: Colors.white, //Color(0xFF4C79FF),
            icon: Icons.insert_chart,
            iconColor: Colors.grey,
          ),
          BottomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestScreen(
                    isoCountryCode: widget.iosCountryCode,
                  ),
                ),
              );
            },
            color: Colors.white,
            icon: Icons.assignment,
            iconColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 140.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            height: 110.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFAFA1E5), Color(0xFF56549E)]),
              borderRadius: BorderRadius.circular(
                18.0,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                left: 130.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestScreen(
                            isoCountryCode: widget.iosCountryCode,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25.0,
                            top: 15.0,
                            bottom: 5.0,
                          ),
                          child: Text(
                            "Do your own test",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 20.0,
                    ),
                    child: Text(
                      "Follow the instruction to do your own test.",
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Image(
              image: AssetImage('images/doc.png'),
              height: 140.0,
            ),
            bottom: 25.0,
            left: 20.0,
          )
        ],
      ),
    );
  }

  Widget _preventions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Prevention",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('images/pre1.jpg'),
                    height: 80.0,
                    width: 80.0,
                  ),
                  Text(
                    "Wash Hands\nOften",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('images/pre2.jpg'),
                    height: 80.0,
                    width: 80.0,
                  ),
                  Text(
                    "Avoid Touching\nEyes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('images/pre3.jpg'),
                    height: 80.0,
                    width: 80.0,
                  ),
                  Text(
                    "Avoid Contact\nWith Sick",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 45.0,),
        //           child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Container(
        //         child: Column(
        //           children: <Widget>[
        //             Image(
        //               image: AssetImage('images/pre4.jpg'),
        //               height: 80.0,
        //               width: 80.0,
        //             ),
        //             Text(
        //               "Stay Home\nAvoid Others",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 14.0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         child: Column(
        //           children: <Widget>[
        //             Image(
        //               image: AssetImage('images/pre5.jpg'),
        //               height: 80.0,
        //               width: 80.0,
        //             ),
        //             Text(
        //               "Cover Face\nWhile Coughing",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 14.0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         child: Column(
        //           children: <Widget>[
        //             Image(
        //               image: AssetImage('images/pre6.jpg'),
        //               height: 80.0,
        //               width: 80.0,
        //             ),
        //             Text(
        //               "Clean, Disinfect\nObjects",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 14.0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _header() {
    return Container(
      height: 250.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Covid-19",
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  height: 40.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: CountryPicker(
                      onChanged: (Country country) {
                        setState(() {
                          _selectedCountry = country;
                        });
                      },
                      selectedCountry: _selectedCountry,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Are you feeling sick?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              "If you feel sick with any of Covid-19 symptoms please call or sms us for immediately help.",
              style: TextStyle(
                fontSize: 15.0,
                height: 1.5,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  color: Color(0xFFFF4D58),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Call Now",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton.icon(
                  color: Color(0xFF4D79FF),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.sms,
                    color: Colors.white,
                  ),
                  label: Text(
                    "SMS Now",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19/screens/home_screen.dart';
import 'package:covid_19/screens/test_screen.dart';
import 'package:covid_19/widgets_utilities/covid.dart';
import 'package:covid_19/widgets_utilities/covid_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:covid_19/widgets_utilities/bottom_button.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class StateScreen extends StatefulWidget {
  String iosCountryCode;
  final covidGlobalData;
  final covidCountryData;
  StateScreen(
      {this.iosCountryCode, this.covidGlobalData, this.covidCountryData});
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  Country selectedCountry;
  List<AppDownloads> data = [];
  List<double> points = [];

  List<String> labels = ["AD", "DH", "RD", "AE", "CL"];

  String formateNumbers(String numberInput) {
    var number = int.parse(numberInput);
    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: number.toDouble());
    return fmf.output.withoutFractionDigits;
  }

  void setData() {
    data = [
      AppDownloads(
        year: 'Affected',
        count: points[0],
        barColor: charts.ColorUtil.fromDartColor(Colors.lime[400]),
      ),
      AppDownloads(
        year: 'Death',
        count: points[1],
        barColor: charts.ColorUtil.fromDartColor(Colors.red[900]),
      ),
      AppDownloads(
        year: 'Recovered',
        count: points[2],
        barColor: charts.ColorUtil.fromDartColor(Colors.greenAccent),
      ),
      AppDownloads(
        year: 'Active',
        count: points[3],
        barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue[300]),
      ),
      AppDownloads(
        year: 'Critical',
        count: points[4],
        barColor: charts.ColorUtil.fromDartColor(Colors.deepPurple[300]),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.covidGlobalData, widget.covidCountryData);

    setData();
  }

  String _place = "country";
  String globalAffected = "";
  String globalDeath = "";
  String globalRecovered = "";
  String globalActive = "";
  String globalCritical = "";

  void updateUI(dynamic decodedGlobalData, dynamic decodedCountryCode) {
    setState(() {
      if (_place == "country") {
        points = [];
        if (decodedCountryCode == 503 || decodedCountryCode == null) {
          globalAffected = "0.0";
          points.add(0.0);
          globalDeath = "0.0";
          points.add(0.0);
          globalRecovered = "0.0";
          points.add(0.0);
          globalActive = "0.0";
          points.add(0.0);
          globalCritical = "0.0";
          points.add(0.0);
        } else {
          globalAffected =
              decodedCountryCode['countrydata'][0]['total_cases'].toString();
          points.add(double.parse(globalAffected));
          globalAffected = formateNumbers(globalAffected).toString();
          globalDeath =
              decodedCountryCode['countrydata'][0]['total_deaths'].toString();
          points.add(double.parse(globalDeath));
          globalDeath = formateNumbers(globalDeath).toString();

          globalRecovered = decodedCountryCode['countrydata'][0]
                  ['total_recovered']
              .toString();
          points.add(double.parse(globalRecovered));
          globalRecovered = formateNumbers(globalRecovered).toString();

          globalActive = decodedCountryCode['countrydata'][0]
                  ['total_active_cases']
              .toString();
          points.add(double.parse(globalActive));
          globalActive = formateNumbers(globalActive).toString();
          globalCritical = decodedCountryCode['countrydata'][0]
                  ['total_serious_cases']
              .toString();
          points.add(double.parse(globalCritical));
          globalCritical = formateNumbers(globalCritical).toString();
        }
      } else {
        points = [];
        if (decodedGlobalData == 503 || decodedGlobalData == null) {
          globalAffected = "0.0";
          points.add(0.0);
          globalDeath = "0.0";
          points.add(0.0);
          globalRecovered = "0.0";
          points.add(0.0);
          globalActive = "0.0";
          points.add(0.0);
          globalCritical = "0.0";
          points.add(0.0);
        } else {
          globalAffected =
              decodedGlobalData['results'][0]['total_cases'].toString();
          points.add(double.parse(globalAffected.replaceAll(",", "")));
          globalAffected = formateNumbers(globalAffected).toString();
          globalDeath =
              decodedGlobalData['results'][0]['total_deaths'].toString();
          points.add(double.parse(globalDeath.replaceAll(",", "")));
          globalDeath = formateNumbers(globalDeath).toString();
          globalRecovered =
              decodedGlobalData['results'][0]['total_recovered'].toString();
          points.add(double.parse(globalRecovered.replaceAll(",", "")));
          globalRecovered = formateNumbers(globalRecovered).toString();
          globalActive =
              decodedGlobalData['results'][0]['total_active_cases'].toString();
          points.add(double.parse(globalActive.replaceAll(",", "")));
          globalActive = formateNumbers(globalActive).toString();
          globalCritical =
              decodedGlobalData['results'][0]['total_serious_cases'].toString();
          points.add(double.parse(globalCritical.replaceAll(",", "")));
          globalCritical = formateNumbers(globalCritical).toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF473F97),
      ),
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'icons/flags/png/${widget.iosCountryCode.toLowerCase()}.png',
                package: 'country_icons',
                fit: BoxFit.contain,
                height: 32,
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Statistics",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: CountryPicker(
                    onChanged: (Country country) {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                    selectedCountry: selectedCountry,
                  ),
                ),
              ],
            ),
            _placeNav(),
            _optionNav(),
            Container(
              height: 220.0,
              padding: const EdgeInsets.all(15),
              child: Card(
                child: MyBarChart(data),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _bottomNavigation(),
      ),
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            iosCountryCode: widget.iosCountryCode,
                          )));
            },
            color: Colors.transparent, //Color(0xFF4C79FF),
            icon: Icons.home,
            iconColor: Colors.grey,
          ),
          BottomButton(
            onPressed: () {},
            color: Color(0xFF4C79FF),
            icon: Icons.insert_chart,
            iconColor: Colors.white,
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

  Widget _optionNav() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              ContainerReusable(
                  Colors.lime[400], "Affected", '$globalAffected'),
              ContainerReusable(Colors.red[900], "Death", '$globalDeath'),
            ],
          ),
          Row(
            children: <Widget>[
              ContainerReusable(
                  Colors.greenAccent, "Recovered", globalRecovered),
              ContainerReusable(Colors.lightBlue[300], "Active", globalActive),
              ContainerReusable(
                  Colors.deepPurple[300], "Serious", globalCritical),
            ],
          ),
        ],
      ),
    );
  }

  Widget _placeNav() {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.0,
        ),
        color: Color(0XFFAEA1E5).withOpacity(0.3),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 48.0,
                ),
                decoration: BoxDecoration(
                  color: _place == "country" ? Colors.white : null,
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                child: Text(
                  "My Country",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _place != "country" ? Colors.white : null,
                  ),
                ),
              ),
              onTap: () async {
                var covidCountry =
                    await Covid().getCountryData(widget.iosCountryCode);
                setState(() {
                  _place = "country";
                  updateUI("", covidCountry);
                  setData();
                });
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 64.0,
                ),
                decoration: BoxDecoration(
                  color: _place == "global" ? Colors.white : null,
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                child: Text(
                  "Global",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _place != "global" ? Colors.white : null,
                  ),
                ),
              ),
              onTap: () async {
                var covidGlobal = await Covid().getGlobalData();
                setState(() {
                  _place = "global";
                  updateUI(covidGlobal, "");
                  setData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerReusable extends StatelessWidget {
  ContainerReusable(this.color, this.title, this.countCases);
  final Color color;
  final String title;
  final String countCases;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              8.0,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                countCases,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBarChart extends StatelessWidget {
  final List<AppDownloads> data;

  MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AppDownloads, String>> series = [
      charts.Series(
          id: 'AppDownloads',
          data: data,
          domainFn: (AppDownloads downloads, _) => downloads.year,
          measureFn: (AppDownloads downloads, _) => downloads.count,
          colorFn: (AppDownloads downloads, _) => downloads.barColor)
    ];

    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
    );
  }
}

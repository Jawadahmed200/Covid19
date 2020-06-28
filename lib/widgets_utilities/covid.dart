import 'package:covid_19/widgets_utilities/covid_helper.dart';

class Covid {
  Future<dynamic> getGlobalData() async {
    CovidHelper covidHelper =
        CovidHelper("https://api.thevirustracker.com/free-api?global=stats");
    //"https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search");

    var covidData = await covidHelper.getData();
    return covidData;
  }

  Future<dynamic> getCountryData(String iosCountryCode) async {
    CovidHelper covidHelper = CovidHelper(
        "https://api.thevirustracker.com/free-api?countryTotal=${iosCountryCode.toUpperCase()}");

    var covidData = await covidHelper.getData();
    return covidData;
  }
}

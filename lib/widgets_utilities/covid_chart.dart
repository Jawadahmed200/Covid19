import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AppDownloads {
  final String year;

  final double count;

  final charts.Color barColor;

  AppDownloads({
    @required this.year,
    @required this.count,
    @required this.barColor,
  });
}

// class CovidCount {
//   final String title;
//   final int casesCount;
//   final charts.Color color;

//   CovidCount(this.title, this.casesCount, Color color)
//       : this.color = new charts.Color(
//             r: color.red, g: color.green, b: color.blue, a: color.alpha);
// }

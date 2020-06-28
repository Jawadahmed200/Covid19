import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/widgets_utilities/bottom_button.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            color: Color(0xFF4C79FF),
            icon: Icons.home,
            iconColor: Colors.white,
          ),
          BottomButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            color: Color(0xFF4C79FF),
            icon: Icons.home,
            iconColor: Colors.white,
          ),
          GestureDetector(
            child: Container(
              height: 40.0,
              width: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(
                Icons.insert_chart,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StateScreen(widget.iosCountryCode),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

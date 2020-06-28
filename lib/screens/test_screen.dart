import 'package:covid_19/models/question_brain.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:covid_19/screens/state_screen.dart';
import 'package:covid_19/widgets_utilities/bottom_button.dart';
import 'package:covid_19/widgets_utilities/covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constant.dart';

class TestScreen extends StatefulWidget {
  String isoCountryCode;
  TestScreen({this.isoCountryCode});
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Covid covid = Covid();
  bool showSpinner = false;
  QuestionBrain questionBrain = QuestionBrain();
  List<bool> answersByUser = [];
  void setUserAnswers() {
    answersByUser = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserAnswers();
  }

  void insertAnswers(index, value) {
    answersByUser[index] = value;
    print(answersByUser);
  }

  int countOccurrencesUsingWhereMethod(bool element) {
    if (answersByUser == null || answersByUser.isEmpty) {
      return 0;
    }

    var foundElements = answersByUser.where((e) => e == element);
    return foundElements.length;
  }

  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF473F97),
      appBar: AppBar(
        elevation: 6.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Test Yourself!",
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: [
            _questionCard(questionBrain.quistionBank[0].questionText, 0),
            _questionCard(questionBrain.quistionBank[1].questionText, 1),
            _questionCard(questionBrain.quistionBank[2].questionText, 2),
            _questionCard(questionBrain.quistionBank[3].questionText, 3),
            _questionCard(questionBrain.quistionBank[4].questionText, 4),
            _questionCard(questionBrain.quistionBank[5].questionText, 5),
            _questionCard(questionBrain.quistionBank[6].questionText, 6),
            _questionCard(questionBrain.quistionBank[7].questionText, 7),
            _questionCard(questionBrain.quistionBank[8].questionText, 8),
            _questionCard(questionBrain.quistionBank[9].questionText, 9),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              onPressed: () {
                var trueAnswers = countOccurrencesUsingWhereMethod(true);
                setUserAnswers();
                if (trueAnswers >= 7) {
                  return Alert(
                    context: context,
                    style: alertStyle,
                    title: "Dangerous",
                    desc:
                        "There are 70% Chances of Corona Virus. Visit Nearest Corona Center.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                  ).show();
                } else if (trueAnswers >= 5) {
                  return Alert(
                    context: context,
                    style: alertStyle,
                    title: "Dangerous",
                    desc:
                        "There are 50% Chances of Corona Virus. Visit Nearest Corona Center.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                  ).show();
                } else if (trueAnswers >= 3) {
                  return Alert(
                    context: context,
                    style: alertStyle,
                    title: "Unsafe",
                    desc: "There are 30% Chances of Corona Virus.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                  ).show();
                } else {
                  return Alert(
                    context: context,
                    style: alertStyle,
                    title: "Safe",
                    desc: "There is Very Less Chances of Corona Virus.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                  ).show();
                }
              },
              child: Text(
                "Test",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.green,
            ),
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            iosCountryCode: widget.isoCountryCode,
                          )));
            },
            color: Colors.transparent, //Color(0xFF4C79FF),
            icon: Icons.home,
            iconColor: Colors.grey,
          ),
          BottomButton(
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });

              var covidGlobal = await covid.getGlobalData();
              var covidCountry =
                  await covid.getCountryData(widget.isoCountryCode);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StateScreen(
                    iosCountryCode: widget.isoCountryCode,
                    covidGlobalData: covidGlobal,
                    covidCountryData: covidCountry,
                  ),
                ),
              );
              setState(() {
                showSpinner = false;
              });
            },
            color: Colors.transparent, //Color(0xFF4C79FF),
            icon: Icons.insert_chart,
            iconColor: Colors.grey,
          ),
          BottomButton(
            onPressed: () {},
            color: Color(0xFF4C79FF),
            icon: Icons.assignment,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _questionCard(questionText, index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Color(0xFFaec2ff),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                questionText,
                style: TextStyle(
                  color: Color(0xFF473F97),
                ),
              ),
              trailing: FlutterSwitch(
                activeText: "Yes",
                inactiveText: "No",
                activeColor: Colors.green,
                inactiveColor: Colors.red,
                value: answersByUser[index],
                valueFontSize: 12.0,
                width: 65,
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    //status = val;
                  });
                  insertAnswers(index, val);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

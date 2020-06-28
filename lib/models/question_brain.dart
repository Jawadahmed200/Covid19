import 'package:covid_19/models/questions.dart';

class QuestionBrain {
  List<Question> quistionBank = [
    Question("Do you have Fever above 101.4?"),
    Question("Do you have Cough - (Dry Cough)?"),
    Question("Do you have Shortness of Breath?"),
    Question("Do you have Runny Nose?"),
    Question("Have you travelled abroad in the last 15 days?"),
    Question(
        "Have you been in contact with any person who has recently travelled internationally?"),
    Question("Do you have chest infection?"),
    Question("Is your age more than or equal to 60 years of age?"),
    Question("Due to Co-morbidities, do you take any medicine?"),
    Question("Do you have Loss of Taste or Smell?"),
  ];
}

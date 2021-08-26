import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

//void main() {
// runApp(MyApp());
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  Widget build(BuildContext context) {
    void _answerQuestion() {
      setState(() {
        _questionIndex = _questionIndex + 1;
      });

      print(_questionIndex);
    }

    /*void returnQuestion() {
      setState(() {
        questionIndex -= 1;
      });
    }*/

    var questions = [
      {
        'questionText': 'What is your favorite color?',
        'answers': ['Black', 'Red', 'Green', 'Blue'],
      },
      {
        'questionText': 'what is your favorite animal?',
        'answers': ['Snake', 'Rabbit', 'Cat', 'Dog'],
      },
      {
        'questionText': 'what is your favorite something else?',
        'answers': ['Hey ', 'Hi', 'Ho', 'He'],
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Question(
              questions[_questionIndex]['questionsText'],
            ),
            (questions[_questionIndex]['answers'] as List<String>)
                .map((answer) {
              return Answer(answer);
            })
          ],
        ),
      ),
    );
  }
}

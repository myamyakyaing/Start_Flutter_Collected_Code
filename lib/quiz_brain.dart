import 'dart:ffi';

import 'package:demo/question.dart';

class QuizBrain{
  int _questionNumber = 0;
  final List<Question> _questionBank = [
    Question('You can lead a cow down stairs but not up stairs.', true),
    Question('Approximately one quarter of human bones are in the feet.', false),
    Question('A slug\'s blood is green.', true)
  ];

  void nextQuestion(){
    if(_questionNumber < _questionBank.length - 1){
      _questionNumber++;
    }else{
      _questionNumber = 0;
    }
  }

  void stayQuestion(){
    if(_questionNumber < _questionBank.length - 1){
      _questionNumber;
    }else{
      _questionNumber = 0;
    }
  }

  String getQuestionText(int questionNumber){
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer(int questionNumber){
    return _questionBank[_questionNumber].questionAnswer;
  }
}
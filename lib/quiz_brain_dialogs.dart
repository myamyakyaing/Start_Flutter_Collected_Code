import 'package:demo/question.dart';

class QuizBrainDialogs{
  int _questionNumber = 0;
  // final List<QuestionForDialog> _questionBankDialogs = [
  //   QuestionForDialog('You can lead a cow down stairs but not up stairs.', true),
  //   QuestionForDialog('Approximately one quarter of human bones are in the feet.', false),
  //   QuestionForDialog('A slug\'s blood is green.', true),
  //   QuestionForDialog('Other animals\'s blood is green.', false),
  //   QuestionForDialog('Other animals\'s blood is red.', true)
  // ];
  final _questionBankDialogs = [];

  void nextQuestion(){
    if(_questionNumber < _questionBankDialogs.length - 1){
      _questionNumber++;
    }else{
      _questionNumber = 0;
    }
  }

  String getQuestionText(int questionNumber){
    return _questionBankDialogs[_questionNumber].questionText;
  }

  bool getQuestionAnswer(){
    return _questionBankDialogs[_questionNumber].questionAnswer;
  }

}
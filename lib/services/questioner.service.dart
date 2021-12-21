import 'package:qwizy/models/question.model.dart';

List<Question> questions = [
  Question(questionText: 'Apple à été créé par John Doe ?', answer: false),
  Question(questionText: 'Ali baba est un voleur ?', answer: true),
  Question(questionText: 'La mayonnaise est une recette Albanaise ?', answer: false),
  Question(questionText: 'Il fait généralement nuit, la nuit ?', answer: false),
  Question(questionText: 'Le calumet est une pipe ?', answer: true),
  Question(questionText: 'Le loup de WallStreet un film de nature ?', answer: false),
  Question(questionText: 'Tous les avions sont équipés de parachute ?', answer: false),
  Question(questionText: 'En montagne, on respire moins bien qu\'en ville ?', answer: true),
  Question(questionText: 'La bête du Gévaudan était en fait un humain ?', answer: true),
  Question(questionText: 'C\'est déjà la dixième question ?', answer: true),
];

class Questioner {
  int _playingIndex = 0;
  Question _activeQuestion = questions[0];
  List<bool> _answers = [];

  String getNextQuestion() {
    return _activeQuestion.questionText;
  }

  bool checkAnswer(bool answer) {
    if (questions.length != _playingIndex) {
      _answers.add(_activeQuestion.answer == answer);
      _playingIndex++;

      if (questions.asMap().containsKey(_playingIndex)) {
        _activeQuestion = questions[_playingIndex];
        return false;
      }
    }

    return true;
  }

  int calculatePercentOfSuccess() {
    var success = _answers.where((item) => item == true).length;

    return (success / 10 * 100).round();
  }

  List<bool> getAnswers() {
    return _answers;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qwizy/services/questioner.service.dart';

class QwizyController extends GetxController {
  Questioner questioner = Questioner();

  RxString question = ''.obs;
  RxList answers = [].obs;

  @override
  void onInit() {
    getNextQuestion();

    super.onInit();
  }

  void getNextQuestion() {
    question(questioner.getNextQuestion());
  }

  void checkAnswer(bool answer) {
    bool openModal = questioner.checkAnswer(answer);
    answers.assignAll(questioner.getAnswers());

    if (openModal) {
      int percentageOfSuccess = questioner.calculatePercentOfSuccess();
      bool isWinner = percentageOfSuccess > 70;

      Get.defaultDialog(
        title: isWinner ? "BRAVO !" : "DOMMAGE !",
        middleText: "Votre pourcentage de réussite est de $percentageOfSuccess%",
        backgroundColor: isWinner ? Colors.green[800] : Colors.red[800],
        titleStyle: const TextStyle(
          color: Colors.white,
        ),
        middleTextStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.all(20),
      );
    } else {
      getNextQuestion();
    }
  }
}

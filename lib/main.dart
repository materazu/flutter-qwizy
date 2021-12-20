import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qwizy/services/questioner.dart';

void main() => runApp(
      GetMaterialApp(
        home: Qwizy(),
      ),
    );

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

class Qwizy extends StatelessWidget {
  final QwizyController controller = Get.put(QwizyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text(
                      controller.question.string,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.checkAnswer(true);
                    },
                    child: const Text('OUI'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.greenAccent[100]),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.checkAnswer(false);
                    },
                    child: const Text('NON'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.redAccent[100]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Obx(
                      () => Row(
                        children: [
                          for (var answer in controller.answers)
                            answer == true
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.lightGreen,
                                  )
                                : const Icon(
                                    Icons.clear,
                                    color: Colors.redAccent,
                                  )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

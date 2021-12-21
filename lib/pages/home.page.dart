import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qwizy/controllers/qwizy.controller.dart';

class HomePage extends StatelessWidget {
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

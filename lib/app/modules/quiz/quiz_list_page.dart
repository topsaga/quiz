import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/data/provider/quiz_provider.dart';
import 'package:quiz/app/data/repository/quiz_repository.dart';
import 'package:quiz/app/modules/quiz/quiz_controller.dart';

class QuizListPage extends GetView<QuizController> {
  QuizListPage({Key? key}) : super(key: key);
  final int id = Get.arguments['categoryId'];

  @override
  final controller = Get.put(QuizController(QuizRepository(QuizProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz List')),
      body: Obx(() {
        // controller.id.value = id;
        controller.getQuizAll(id);
        // if (controller.loading.value == true) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        return ListView.builder(
          itemCount: controller.quizList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(controller.quizList[index].question),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                },
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                  }),
            ]),
          ),
        );
      }),
    );
  }
}

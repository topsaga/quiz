import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/data/provider/quiz_provider.dart';
import 'package:quiz/app/data/repository/quiz_repository.dart';
import 'package:quiz/app/modules/quiz/quiz_controller.dart';
import 'package:quiz/app/modules/quiz/api_controller.dart';

class CategoryApiListPage extends GetView<ApiCategoryController> {
  CategoryApiListPage({Key? key}) : super(key: key);

  final categoryController =
      Get.put(CategoryController(CategoryRepository(CategoryProvider())));
  final quizController =
      Get.put(QuizController(QuizRepository(QuizProvider())));

  final apiCategoryController = Get.put(ApiCategoryController());
  // final apiQuizController = Get.put(ApiQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('서버 내 문제 카테고리 목록')),
      body: Obx(() {
        if (apiCategoryController.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: apiCategoryController.categoryApiList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title:
                Text(apiCategoryController.categoryApiList[index].categoryName),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  apiCategoryController
                      .manipulate(apiCategoryController.categoryApiList[index])
                      .then((value) { Get.back(); });
                },
              ),
            ]),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/data/provider/quiz_provider.dart';
import 'package:quiz/app/data/repository/quiz_repository.dart';
import 'package:quiz/app/modules/quiz/quiz_controller.dart';
import 'package:quiz/app/modules/quiz/category_api_list_page.dart';
import 'package:quiz/app/modules/quiz/quiz_list_page.dart';

class CategoryListPage extends StatelessWidget {
  CategoryListPage({Key? key}) : super(key: key);

  final categoryController = Get.put(CategoryController(CategoryRepository(CategoryProvider())));
  final quizController = Get.put(QuizController(QuizRepository(QuizProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Category List')),
      body: Obx(() {
        if (categoryController.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: categoryController.categoryList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(categoryController.categoryList[index].categoryName),
            trailing: Wrap(children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: '문제 카테고리 삭제',
                        middleText:
                            '정말 "${categoryController.categoryList[index].categoryName}" 카테고리를 삭제하시겠습니까?',
                        textCancel: '취소',
                        onConfirm: () {
                          categoryController.deleteCategory(
                              categoryController.categoryList[index]);
                          quizController.deleteQuizAll(
                              categoryController.categoryList[index]);
                          if (categoryController.loading.value == true) {
                            Get.dialog(
                              const Center(child: CircularProgressIndicator()),
                            );
                          }
                        });
                  }),
            ]),
            onTap: () {
              Get.to(
                () => QuizListPage(),
                arguments: {
                  'categoryId': categoryController.categoryList[index].id,
                }
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.to(() => CategoryApiListPage());
          // categoryController.onReady();
        },
      ),
    );
  }
}

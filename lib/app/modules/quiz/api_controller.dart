import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/app/data/model/quiz_model.dart';
import 'package:quiz/app/data/provider/quiz_provider.dart';
import 'package:quiz/app/data/repository/quiz_repository.dart';
import 'package:quiz/app/modules/quiz/quiz_controller.dart';

class ApiQuizController extends GetxController {
  // var quizApiList = <Quiz>[].obs;

  List<dynamic> quizApiList = [];
  var isLoading = true.obs;

  Future<void> fetchQuizData(Category category) async {

    final uri = Uri.parse('https://topsaga03.cafe24.com/get_quiz.php').replace(query:'id=${category.id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var decodedString = jsonDecode(jsonString);

      for (int i = 0; i < decodedString.length; i++) {
        Quiz apiQuiz = Quiz.fromJson(decodedString[i]);

        quizApiList.add(
          Quiz(
            categoryId: category.id!,
            question: apiQuiz.question,
            answer: apiQuiz.answer,
            hint: apiQuiz.hint,
            memorized: apiQuiz.memorized,
          ),
        );

      }

      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Server responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }

}

class ApiCategoryController extends GetxController {

  final categoryController = Get.put(CategoryController(CategoryRepository(CategoryProvider())));
  final quizController = Get.put(QuizController(QuizRepository(QuizProvider())));

  var categoryApiList = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    final response = await http.get(Uri.parse('https://topsaga03.cafe24.com/get_category.php'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var decodedString = jsonDecode(jsonString);

      for (int i = 0; i < decodedString.length; i++) {
        Category apiCategory = Category.fromJson(decodedString[i]);

        categoryApiList.add(
          Category(
            id: apiCategory.id,
            categoryName: apiCategory.categoryName,
          ),
        );

      }

      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Server responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }

  Future<void> manipulate(Category category) async {

    // category에 카테고리 저장
    categoryController.addCategory(category);

    // quiz에 문제 저장
    var apiQuizController = ApiQuizController();

    await apiQuizController.fetchQuizData(category);
    for( var data in apiQuizController.quizApiList ) {
      quizController.saveQuiz(data);
    }
  }
}



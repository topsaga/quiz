import 'package:get/get.dart';
import 'package:quiz/app/data/model/quiz_model.dart';
import 'package:quiz/app/db/quiz_service.dart';

class QuizProvider {
  final quizService = Get.find<QuizService>();

  Future<List<Quiz>> getQuizAll(int categoryId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await quizService.getQuizAll(categoryId);
  }

  Future<Quiz> saveQuiz(Quiz quiz) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await quizService.saveQuiz(quiz);
  }

  Future<Quiz> updateQuiz(Quiz quiz) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await quizService.updateQuiz(quiz);
  }

  Future<int> deleteQuiz(int quizId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await quizService.deleteQuiz(quizId);
  }
}

class CategoryProvider {
  final categoryService = Get.find<QuizService>();

  Future<List<Category>> getCategoryAll() async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await categoryService.getCategoryAll();
  }

  Future<Category> saveCategory(Category category) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await categoryService.saveCategory(category);
  }

  Future<Category> updateCategory(Category category) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await categoryService.updateCategory(category);
  }

  Future<int> deleteCategory(int categoryId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(const Duration(seconds: 2));
    return await categoryService.deleteCategory(categoryId);
  }
}
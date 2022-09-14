import 'package:quiz/app/data/model/quiz_model.dart';
import 'package:quiz/app/data/provider/quiz_provider.dart';

class QuizRepository {
  final QuizProvider api;
  QuizRepository(this.api);

  getQuizAll(int categoryId) {
    return api.getQuizAll(categoryId);
  }

  saveQuiz(Quiz quiz) {
    return api.saveQuiz(quiz);
  }

  updateQuiz(Quiz quiz) {
    return api.updateQuiz(quiz);
  }

  deleteQuiz(int id) {
    return api.deleteQuiz(id);
  }
}

class CategoryRepository {
  final CategoryProvider api;
  CategoryRepository(this.api);

  getCategoryAll() {
    return api.getCategoryAll();
  }

  saveCategory(Category category) {
    return api.saveCategory(category);
  }

  updateCategory(Category category) {
    return api.updateCategory(category);
  }

  deleteCategory(int id) {
    return api.deleteCategory(id);
  }
}
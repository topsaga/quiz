import 'package:get/get.dart';
import 'package:quiz/app/data/model/quiz_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuizService extends GetxService {
  late Database db;

  Future<QuizService> init() async {
    db = await _getDatabase();

    return this;
  }

  Future<Database> _getDatabase() async {
    var databasesPath = await getDatabasesPath();

    return db = await openDatabase(
      join(databasesPath, 'quiz.db'),
      onCreate: (db, version) => _createDb(db),
      version: 1,
    );
  }

  static void _createDb(Database db) {
    db.execute('''
      CREATE TABLE quiz (id INTEGER PRIMARY KEY, categoryId INTEGER, question TEXT, answer TEXT, hint TEXT, memorized INTEGER);
    ''');
    db.execute('''
      CREATE TABLE category (id INTEGER PRIMARY KEY, categoryName TEXT);
    ''');
  }

  Future<List<Quiz>> getQuizAll(int categoryId) async {
    try {
      final sql = "SELECT * FROM quiz WHERE categoryId = $categoryId ORDER BY id ASC";
  // final result = await db.rawQuery(
  //     'SELECT * FROM quiz WHERE categoryId = ? ORDER BY id ASC',
  //     [categoryId]);
      // 'SELECT * FROM quiz ORDER BY id');
  final result = await db.rawQuery(sql);
    return result.map((json) => Quiz.fromJson(json)).toList();
} on Exception catch (e) {
  print(e);
  return [];
}

  }

  Future<Quiz> saveQuiz(Quiz quiz) async {
    final id = await db.rawInsert(
        'INSERT INTO quiz (categoryId, question, answer, hint, memorized) VALUES (?,?,?,?,?)',
        [quiz.categoryId, quiz.question, quiz.answer, quiz.hint, quiz.memorized]);

    return quiz.copy(id: id);
  }

  Future<Quiz> updateQuiz(Quiz quiz) async {
    final id = await db.rawUpdate(
        'UPDATE quiz SET categoryId = ?, question = ?, answer = ?, hint = ?, memorized = ? WHERE id = ?',
        [quiz.categoryId, quiz.question, quiz.answer, quiz.hint, quiz.memorized, quiz.id]);

    return quiz.copy(id: id);
  }

  Future<int> deleteQuiz(int quizId) async {
    final id = await db.rawDelete('DELETE FROM quiz WHERE id = ?', [quizId]);

    return id;
  }


  Future<List<Category>> getCategoryAll() async {
    final result = await db.rawQuery('SELECT * FROM category ORDER BY id');
    return result.map((json) => Category.fromJson(json)).toList();
  }

  Future<Category> saveCategory(Category category) async {
    final id = await db.rawInsert(
      'INSERT INTO category (categoryName) VALUES (?)', [category.categoryName]);

    return category.copy(id: id);
  }

  Future<Category> updateCategory(Category category) async {
    final id = await db.rawUpdate(
      'UPDATE category SET categoryName = ? WHERE id = ?',
      [category.categoryName, category.id]);

    return category.copy(id: id);
  }

  Future<int> deleteCategory(int categoryId) async {
    final id = await db.rawDelete('DELETE FROM category WHERE id = ?', [categoryId]);

    return id;
  }


  Future close() async {
    db.close();
  }

}

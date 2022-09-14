import 'dart:convert';

List<Quiz> quizFromJson(String str) => List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));
String quizToJson(List<Quiz> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
  Quiz({
    this.id,
    required this.categoryId,
    required this.question,
    required this.answer,
    this.hint,
    this.memorized,
  });

  int? id;
  int categoryId;
  String question;
  String answer;
  String? hint;
  int? memorized;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["id"],
    categoryId: json["categoryId"],
    question: json["question"],
    answer: json["answer"],
    hint: json["hint"],
    memorized: json["memorized"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "question": question,
    "answer": answer,
    "hint": hint,
    "memorized": memorized,
  };

  Quiz copy({
    int? id,
    int? categoryId,
    String? question,
    String? answer,
    String? hint,
    int? memorized,
  }) =>
    Quiz(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      hint: hint ?? this.hint,
      memorized: memorized ?? this.memorized,
    );
}


List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));
String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    required this.categoryName,
  });

  int? id;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
  };

  Category copy({
    int? id,
    String? categoryName,
  }) =>
    Category(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
    );
}
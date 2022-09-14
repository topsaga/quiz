import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/data/model/quiz_model.dart';
import 'package:quiz/app/data/repository/quiz_repository.dart';
import 'package:quiz/app/modules/quiz/api_controller.dart';

class QuizController extends GetxController {
  final QuizRepository quizRepository;
  QuizController(this.quizRepository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;
  // var categoryId = 0.obs;

  //variaveis da lista de notas
  final quizList = <Quiz>[].obs;

  //recuperar todas as notas
  getQuizAll(int categoryId) {
    // quizRepository.getQuizAll(categoryId);
    loading(true);
    quizRepository.getQuizAll(categoryId).then((data) {
      quizList.value = data;
      loading(false);
    });
  }


  saveQuiz(Quiz quiz) async {
    quizRepository.saveQuiz(quiz);
    // final quiz = Quiz(
    //   question: questionController.text.trim(),
    //   answer: answerController.text.trim(),
    //   hint: hintController.text.trim(),
    // );
    // quizRepository.saveQuiz(quiz).then((data) {
    //   loading(false);
    //   refreshQuizList();
    // });
  }

  deleteQuizAll(Category category) {
    print(category.id);
  }

  //tratar formulario para inclusao de uma nota
  // addQuiz() {
  //   formKey.currentState?.reset();
  //   questionController.text = '';
  //   answerController.text = '';
  //   hintController.text = '';
  //   titulo = 'Incluir Nota';
  //   // Get.to(() => QuizEditPage());
  // }

  //tratar formulario para edicao de uma nota passando id via arguments
  // editQuiz(Quiz quiz) {
  //   questionController.text = quiz.question;
  //   answerController.text = quiz.answer;
  //   titulo = 'Editar Nota';
  //   // Get.to(() => QuizEditPage(), arguments: quiz.id);
  // }

  //verificar se o formulario esta validado sem erros
  //e se um id de nota eh enviado para a tela de edicao
  //a nota sera atualizada, caso contrario sera criada uma nova nota
  // editMode() {
  //   answerFocusNode.unfocus();
  //   if (formKey.currentState!.validate()) {
  //     loading(true);
  //     if (Get.arguments == null) {
  //       // saveQuiz();
  //     } else {
  //       updateQuiz();
  //     }
  //   }
  // }


  // //atualizar uma nota existente cujo id eh recuperado via arguments
  // updateQuiz() async {
  //   final quiz = Quiz(
  //     id: Get.arguments,
  //     categoryId: Get.arguments,
  //     question: questionController.text.trim(),
  //     answer: answerController.text.trim(),
  //     hint: hintController.text.trim(),
  //   );
  //   quizRepository.updateQuiz(quiz).then((data) {
  //     loading(false);
  //     refreshQuizList();
  //   });
  // }

  // atualizar lista de notas apos uma inclusao, alteracao ou exclusao
  // refreshQuizList() {
  //   // recuperar lista de notas
  //   getQuizAll();
  //   //fechar dialog
  //   Get.back();
  //   //voltar para a lista de notas
  //   Get.back();
  // }

  // validar campo titulo
  validQuestion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo Título.';
    }
    return null;
  }

  //validar campo conteudo
  validAnswer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo Conteúdo.';
    }
    return null;
  }
}

// Category Controller
class CategoryController extends GetxController {
  final CategoryRepository categoryRepository;
  CategoryController(this.categoryRepository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final categoryList = <Category>[].obs;

  //recuperar notas para apresentar na tela inicial
  @override
  void onReady() async {
    super.onReady();
    getCategoryAll();
  }

  //recuperar todas as notas
  getCategoryAll() {
    loading(true);
    categoryRepository.getCategoryAll().then((data) {
      categoryList.value = data;
      loading(false);
    });
  }

  addCategory(Category category) async {
    loading(true);
    categoryRepository.saveCategory(category).then((data) {
      categoryList.add(data);
      categoryList.refresh();
      loading(false);
    });
  }


  //tratar formulario para edicao de uma nota passando id via arguments
  editCategory(Category category) {
    // categoryController.text = category.categoryName;
    // titulo = 'Editar Nota';
    // // Get.to(CategoryEditPage(), arguments: category.id);
  }

  //verificar se o formulario esta validado sem erros
  //e se um id de nota eh enviado para a tela de edicao
  //a nota sera atualizada, caso contrario sera criada uma nova nota
  editMode() {
    // categoryFocusNode.unfocus();
    // if (formKey.currentState!.validate()) {
    //   loading(true);
    //   if (Get.arguments == null) {
    //     // saveCategory();
    //   } else {
    //     updateCategory();
    //   }
    // }
  }


  //atualizar uma nota existente cujo id eh recuperado via arguments
  updateCategory() async {
    // final category = Category(
    //   id: Get.arguments,
    //   categoryName: categoryController.text.trim(),
    // );
    // categoryRepository.updateCategory(category).then((data) {
    //   loading(false);
    //   refreshCategoryList();
    // });
  }

  //excluir nota via id
  deleteCategory(Category category) async {
    loading(true);
    categoryRepository.deleteCategory(category.id!).then((data) {
      loading(false);
      refreshCategoryList();
    });
  }

  // atualizar lista de notas apos uma inclusao, alteracao ou exclusao
  refreshCategoryList() {
    // recuperar lista de notas
    getCategoryAll();
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }

  // validar campo titulo
  validCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo Título.';
    }
    return null;
  }
}

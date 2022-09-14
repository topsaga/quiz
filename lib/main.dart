import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/db/quiz_service.dart';
import 'package:quiz/app/modules/quiz/category_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => QuizService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX SQLite Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoryListPage(),
    );
  }
}

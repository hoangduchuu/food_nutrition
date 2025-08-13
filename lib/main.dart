import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'data/api/todo_api.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'home/home_provider.dart';
import 'home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ));
    
    return MultiProvider(
      providers: [
        Provider<TodoRepository>(
          create: (context) => TodoRepositoryImpl(TodoApi(dio)),
        ),
        
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
            context.read<TodoRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Food Nutrition App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

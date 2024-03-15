import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_task/feature/home/bloc/todo_bloc.dart';
import 'package:todo_task/feature/home/data/todo.repo.dart';
import 'package:todo_task/feature/theme/bloc/theme_bloc.dart';

import 'feature/home/presentation/home.page.dart';

void main() {
  GetStorage.init();
  GetStorage().writeIfNull('totalTodo', 0);
  runApp(RepositoryProvider(
    create: (context) => TodoRepository(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(context.read<TodoRepository>()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<ThemeBloc>().state.theme,
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_task/core/theme.dart';
import 'package:todo_task/feature/home/bloc/todo_bloc.dart';
import 'package:todo_task/feature/home/data/todo.model.dart';
import 'package:todo_task/feature/theme/bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(LoadTodo());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Todo'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(hintText: 'Title'),
                      ),
                      TextField(
                        controller: descController,
                        decoration:
                            const InputDecoration(hintText: 'description'),
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        final req = TodoModel(
                            title: titleController.text,
                            description: descController.text);
                        final int length = await GetStorage().read('totalTodo');

                        context
                            .read<TodoBloc>()
                            .add(AddTodo(task: req, id: length));
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TodoList',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      print(state.theme);
                      return Switch(
                        value: context.watch<ThemeBloc>().isDark,
                        onChanged: (val) {
                          context.read<ThemeBloc>().add(ToggleTheme());
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TodoError) {
                  return Text(state.error);
                }
                if (state is TodoLoaded) {
                  return ListView.builder(
                    itemCount: state.todoList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var task = state.todoList[index];
                      return Column(
                        children: [
                          Text(task.title),
                          Text(task.description),
                          Text(!task.isCompleted
                              ? 'Not Completed Yet'
                              : 'Completed'),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(UpdateTodo(id: index));
                            },
                            child: const Text('Mark Completed'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context
                                    .read<TodoBloc>()
                                    .add(DeleteTodo(id: index));
                              },
                              child: Text('Delete this task'))
                        ],
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}

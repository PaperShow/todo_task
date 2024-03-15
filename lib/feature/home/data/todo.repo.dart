import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:todo_task/feature/home/data/todo.model.dart';

class TodoRepository {
  Future addTask(TodoModel task, int id) async {
    String encodedTask = jsonEncode(task.toMap());
    await GetStorage().write(id.toString(), encodedTask);
    await GetStorage().write('totalTodo', id + 1);

    return GetStorage().read('totalTodo');
  }

  Future updateTodo(int id) async {
    final res = GetStorage().read(id.toString());
    final task = TodoModel.fromMap(jsonDecode(res));
    task.isCompleted = true;
    String encodedTask = jsonEncode(task.toMap());
    await GetStorage().write(id.toString(), encodedTask);
  }

  deleteTodo(int id) async {
    await GetStorage().remove(id.toString());
  }
}

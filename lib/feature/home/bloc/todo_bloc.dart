import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_task/feature/home/data/todo.model.dart';
import 'package:todo_task/feature/home/data/todo.repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc(this.repository) : super(TodoInitial()) {
    on<LoadTodo>(_getTask);
    on<AddTodo>(_addTask);
    on<UpdateTodo>(_updateTask);
    on<DeleteTodo>(_deleteTask);
  }

  _addTask(AddTodo event, Emitter<TodoState> emit) async {
    try {
      await repository.addTask(event.task, event.id);
      add(LoadTodo());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  _updateTask(UpdateTodo event, Emitter<TodoState> emit) async {
    try {
      await repository.updateTodo(event.id);
      add(LoadTodo());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  _deleteTask(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      await repository.deleteTodo(event.id);
      add(LoadTodo());
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  _getTask(LoadTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      int n = await GetStorage().read('totalTodo');
      print(n);
      List<TodoModel> list = [];
      for (int i = 0; i < n; i++) {
        String res = GetStorage().read(i.toString());
        list.add(TodoModel.fromMap(jsonDecode(res)));
      }
      emit(TodoLoaded(todoList: list));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}

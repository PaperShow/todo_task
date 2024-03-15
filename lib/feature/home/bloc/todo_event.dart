part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class LoadTodo extends TodoEvent {}

final class AddTodo extends TodoEvent {
  final TodoModel task;
  final int id;

  const AddTodo({required this.task, required this.id});

  @override
  List<Object> get props => [task, id];
}

final class UpdateTodo extends TodoEvent {
  final int id;

  const UpdateTodo({required this.id});

  @override
  List<Object> get props => [id];
}

final class DeleteTodo extends TodoEvent {
  final int id;

  const DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}

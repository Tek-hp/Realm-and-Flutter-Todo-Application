part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final TodoRealmModel todo;

  const AddTodoEvent(this.todo);
}

class ReadTodoEvent extends TodoEvent {}

class UpdateTodoEvent extends TodoEvent {
  final TodoRealmModel todo;

  UpdateTodoEvent(this.todo) {
    log('Yoooooooooooo -- ${todo.getSTringValue()}');
  }
}

class DeleteTodoEvent extends TodoEvent {
  final TodoRealmModel todo;

  const DeleteTodoEvent(this.todo);
}

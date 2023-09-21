import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
    on<DeleteTodo>(_deleteTodo);
  }

  Future<void> _addTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(TodoAddInitialState());
    await Future.delayed(const Duration(seconds: 2));
    emit(TodoAddSuccessState());
  }

  Future<void> _updateTodo(UpdateTodo event, Emitter<TodoState> emit) async {}
  Future<void> _deleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {}
}

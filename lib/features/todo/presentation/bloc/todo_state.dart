part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitialState extends TodoState {}

class AddTodoState extends TodoState {}

class TodoSuccessState extends TodoState {
  final TodoSuccessType? successType;
  final List<TodoRealmModel>? data;

  const TodoSuccessState({this.successType, this.data = const []});

  TodoSuccessState copyWith({TodoSuccessType? successType, List<TodoRealmModel>? data}) {
    return TodoSuccessState(
      successType: successType ?? this.successType,
      data: data ?? this.data,
    );
  }
}

class TodoLoadingState extends TodoState {
  final String loadingMessage;

  const TodoLoadingState({required this.loadingMessage});
}

class TodoFailureState extends TodoState {
  final String errorMessage;

  const TodoFailureState({required this.errorMessage});
}

enum TodoSuccessType {
  read,
  add,
  update,
  delete,
}

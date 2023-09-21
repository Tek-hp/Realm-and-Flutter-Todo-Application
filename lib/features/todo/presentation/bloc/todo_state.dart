part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState({this.loading = false});

  final bool loading;

  @override
  List<Object> get props => [loading];
}

class TodoInitialState extends TodoState {}

class TodoAddInitialState extends TodoState {}

class TodoAddSuccessState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoFailureState extends TodoState {}

part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState({this.loading = false});

  final bool loading;

  @override
  List<Object> get props => [loading];
}

class TodoInitial extends TodoState {}

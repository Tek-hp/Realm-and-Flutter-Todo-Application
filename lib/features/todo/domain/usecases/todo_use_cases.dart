import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:realm/realm.dart';

import 'package:todorealm/core/use_cases/usecases.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUseCase implements UseCase<bool, TodoRealmModel> {
  final TodoRepository _repository;

  AddTodoUseCase(this._repository);
  @override
  bool call(TodoRealmModel todo) {
    try {
      _repository.addTodo(todo);
      return true;
    } on Exception catch (e) {
      log('', error: e.toString(), name: 'Add Todo');
      return false;
    }
  }
}

class UpdateTodoUseCase implements UseCase<bool, TodoRealmModel> {
  final TodoRepository _repository;

  UpdateTodoUseCase(this._repository);
  @override
  bool call(TodoRealmModel todo) {
    try {
      _repository.updateTodo(todo);
      return true;
    } on Exception catch (e) {
      log('', error: e.toString(), name: 'Update Todo');
      return false;
    }
  }
}

class DeleteTodoUseCase implements UseCase<bool, TodoRealmModel> {
  final TodoRepository _repository;

  DeleteTodoUseCase(this._repository);
  @override
  bool call(TodoRealmModel todo) {
    try {
      _repository.deleteTodo(todo);
      return true;
    } on Exception catch (e) {
      log('', error: e.toString(), name: 'Add Todo');
      return false;
    }
  }
}

typedef TodoReadResponse = Either<String, RealmResults<TodoRealmModel>>;

class ReadTodoUseCase implements UseCase<TodoReadResponse, dynamic> {
  final TodoRepository _repository;

  ReadTodoUseCase(this._repository);
  @override
  TodoReadResponse call(useNullValue) {
    try {
      final result = _repository.readTodo();

      return Right(result);
    } on Exception catch (e) {
      log('', error: e.toString(), name: 'Add Todo');
      return left(e.toString());
    }
  }
}

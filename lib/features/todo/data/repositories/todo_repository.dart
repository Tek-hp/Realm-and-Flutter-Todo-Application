import 'package:realm/realm.dart';
import 'package:todorealm/features/todo/data/datasources/todo_data_source.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(TodoRemoteSource remoteSource) : _remoteSource = remoteSource;

  late final TodoRemoteSource _remoteSource;

  @override
  void addTodo(TodoRealmModel todo) {
    _remoteSource.addTodo(todo);
  }

  @override
  void updateTodo(TodoRealmModel todo) {
    _remoteSource.updateTodo(todo);
  }

  @override
  void deleteTodo(TodoRealmModel todo) {
    _remoteSource.deleteTodo(todo);
  }

  @override
  RealmResults<TodoRealmModel> readTodo() {
    return _remoteSource.readTodo();
  }
}

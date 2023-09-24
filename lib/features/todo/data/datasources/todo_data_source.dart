import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:todorealm/core/realm/realm_service.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';

class TodoRemoteSource {
  TodoRemoteSource(RealmService realmService) : _realmService = realmService;

  final RealmService _realmService;

  RealmResults<TodoRealmModel> readTodo() {
    return _realmService.readItems<TodoRealmModel>();
  }

  void addTodo(TodoRealmModel todo) {
    log(todo.summary, name: 'Remote Todo Summary :: ');
    _realmService.addItem<TodoRealmModel>(todo);
  }

  Future<void> updateTodo(TodoRealmModel todo) async {
    _realmService.updateItem<TodoRealmModel>(todo);
  }

  void deleteTodo(TodoRealmModel todo) {
    
    _realmService.deleteItem(todo);
  }
}

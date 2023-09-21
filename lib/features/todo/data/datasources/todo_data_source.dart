import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';

class TodoDataSource {
  late Realm _realm;
  late App app;
  User? _currentUser;

  TodoDataSource() {
    final appId = dotenv.env['APPLICATION_ID']; //Fetching Application Id from Source File.
    app = App(AppConfiguration(appId!));

    loginUser().then((user) {
      _currentUser = user;
      _realm = Realm(Configuration.flexibleSync(_currentUser!, [TodoRealmModel.schema]));
    });

    log('Initiated Realm-Client Application :\nClient ID : ${app.currentUser}', name: '--Todo-Data-Source--');

    if (app.currentUser != null || _currentUser != app.currentUser) {
      _currentUser ??= app.currentUser;
      _realm = Realm(Configuration.flexibleSync(_currentUser!, [TodoRealmModel.schema]));

      if (_realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<User> loginUser() async {
    return await app.logIn(Credentials.anonymous());
  }

  Future<void> updateSubscriptions() async {
    _realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();

      mutableSubscriptions.add<TodoRealmModel>(_realm.all<TodoRealmModel>());
    });
    await _realm.subscriptions.waitForSynchronization();
  }

  void createTodo(TodoRealmModel newTodo) {
    _realm.write<TodoRealmModel>(() => _realm.add<TodoRealmModel>(newTodo));
  }

  Future<void> updateTodo(TodoRealmModel data, {String? summary, bool? isComplete}) async {
    _realm.write(() {
      if (summary != null) {
        data.summary = summary;
      }
      if (isComplete != null) {
        data.isComplete = isComplete;
      }
    });
  }

  void deleteTodo(TodoRealmModel item) {
    _realm.write(() => _realm.delete(item));
  }

  Future<void> close() async {
    if (_currentUser != null) {
      await _currentUser?.logOut();
      _currentUser = null;
    }
    _realm.close();
  }
}

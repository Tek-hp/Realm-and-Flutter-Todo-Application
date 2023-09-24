import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/extention/realm_extension.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';

class RealmService {
  User? loggedInuser;
  late Realm _realmHelper;
  late final App _app;

  RealmService() : _app = App(AppConfiguration(dotenv.env['APPLICATION_ID']!));

  Future<void> logInAnonymous() async {
    loggedInuser = await _app.logIn(Credentials.anonymous());
    _realmHelper = Realm(Configuration.flexibleSync(loggedInuser!, [TodoRealmModel.schema]));

    _updateSubscriptions();
  }

  RealmResults<T> readItems<T extends RealmObject>() {
    return _realmHelper.query<T>("TRUEPREDICATE SORT(_id ASC)");
  }

  Future<void> _updateSubscriptions() async {
    _realmHelper.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();

      mutableSubscriptions.add(_realmHelper.all<TodoRealmModel>());
    });
    await _realmHelper.subscriptions.waitForSynchronization();
    todoChangeSubscription();
  }

  todoChangeSubscription() {
    _realmHelper.all<TodoRealmModel>().changes.listen((event) {
      log('', error: '============================================================');
      for (var item in event.results) {
        log(item.getSTringValue(), name: 'Inside Listener');
      }
    });
  }

  Future<void> addItem<T extends RealmObject>(T item) async {
    _realmHelper.write<T>(() => _realmHelper.add<T>(item));
  }

  void updateItem<T extends RealmObject>(T updatedItem) async {
    _realmHelper.write(() {
      _realmHelper.add(updatedItem, update: true);
    });

    await _realmHelper.syncSession.waitForUpload();
  }

  void deleteItem(TodoRealmModel todo) async {
    _realmHelper.write(() {
      // _realmHelper.delete(_realmHelper.query('_id == ${todo.id}')[0]);
      final itemFromHelper = _realmHelper.query('_id == ${todo.id}');

      log('Total Items = ${itemFromHelper.length}');
    });
  }
}

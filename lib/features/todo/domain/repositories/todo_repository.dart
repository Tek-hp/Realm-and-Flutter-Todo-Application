import 'package:realm/realm.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';

abstract class TodoRepository {
  RealmResults<TodoRealmModel> readTodo();
  void addTodo(TodoRealmModel todo);
  void updateTodo(TodoRealmModel todo);
  void deleteTodo(TodoRealmModel todo);
}

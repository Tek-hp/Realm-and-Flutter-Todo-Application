import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';

extension RealmExt on TodoRealmModel {
  getSTringValue() {
    return 'Todo(id : $id, summary : $summary, isComplete : $isComplete)';
  }

  copyWith({String? summary, bool? isComplete}) {
    return TodoRealmModel(id, summary ?? this.summary, isComplete ?? this.isComplete);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_realm_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TodoRealmModel extends _TodoRealmModel
    with RealmEntity, RealmObjectBase, RealmObject {
  TodoRealmModel(
    ObjectId id,
    String summary,
    bool isComplete,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'summary', summary);
    RealmObjectBase.set(this, 'isComplete', isComplete);
  }

  TodoRealmModel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get summary => RealmObjectBase.get<String>(this, 'summary') as String;
  @override
  set summary(String value) => RealmObjectBase.set(this, 'summary', value);

  @override
  bool get isComplete => RealmObjectBase.get<bool>(this, 'isComplete') as bool;
  @override
  set isComplete(bool value) => RealmObjectBase.set(this, 'isComplete', value);

  @override
  Stream<RealmObjectChanges<TodoRealmModel>> get changes =>
      RealmObjectBase.getChanges<TodoRealmModel>(this);

  @override
  TodoRealmModel freeze() => RealmObjectBase.freezeObject<TodoRealmModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TodoRealmModel._);
    return const SchemaObject(
        ObjectType.realmObject, TodoRealmModel, 'TodoRealmModel', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('summary', RealmPropertyType.string),
      SchemaProperty('isComplete', RealmPropertyType.bool),
    ]);
  }
}

import 'package:realm/realm.dart';
part 'todo_realm_model.g.dart';

@RealmModel()
class _TodoRealmModel {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;

  late String summary;
  late bool isComplete;
}

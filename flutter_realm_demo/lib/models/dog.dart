import 'package:realm/realm.dart';
part 'dog.realm.dart';

@RealmModel()
class _Dog {
  @PrimaryKey()
  late ObjectId id;

  String? name;
  int? age = 0;

  _Person? owner;
}

@RealmModel()
class _Person {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  int age = 1;
}

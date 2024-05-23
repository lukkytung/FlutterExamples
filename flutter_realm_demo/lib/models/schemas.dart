import 'package:realm/realm.dart';
part 'schemas.realm.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;

  late String make;
  String? model;
  int? kilometers = 500;

  _Person? owner;
}

@RealmModel()
class _Dog {
  @PrimaryKey()
  late ObjectId id;

  late String make;
  String? model;
  int? kilometers = 500;

  _Person? owner;
}

@RealmModel()
class _Person {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  int age = 1;
}

@RealmModel()
class _Tag {
  @PrimaryKey()
  late ObjectId id;

  late String name;
}

@RealmModel()
class _Item {
  @PrimaryKey()
  late ObjectId id;

  late List<_Tag> tags;
}

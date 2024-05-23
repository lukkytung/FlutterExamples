import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../models/schemas.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Realm realm;

  @override
  void initState() {
    final config = Configuration.local([Tag.schema, Item.schema]);

    realm = Realm(config);

    realmCRUD();
    super.initState();
  }

  void realmCRUD() {
    // 添加默认数据
    final tag1 = Tag(ObjectId(), '汽车');
    final tag2 = Tag(ObjectId(), '飞机');
    final item1 = Item(ObjectId(), tags: [tag1, tag2]);
    final item2 = Item(ObjectId(), tags: [tag2]);
    realm.write(() {
      realm.add(tag1);
      realm.add(tag2);
      realm.add(item1);
      realm.add(item2);
    });

    var tagNameToSearch = '汽车';

    // var queryStr = 'tags.name == $tagNameToSearch';
    // final results = realm.all<Item>().query(queryStr);
    final results = realm.all<Item>().query(r'tags.name == $0', [tagNameToSearch]);

    // 使用过滤器查询包含特定标签名的Item对象
    // final results = realm.all<Item>().where((item) {
    //   return item.tags.any((tag) => tag.name == tagNameToSearch);
    // }).toList();

    for (var item in results) {
      print(
          '===Found item with id: ${item.id} and tags: ${item.tags.map((t) => t.name).join(', ')}');
    }
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

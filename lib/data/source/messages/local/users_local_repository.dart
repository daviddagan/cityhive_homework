import 'dart:convert';
import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:cityhive_homework/data/source/messages/messages_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessagesLocalRepository implements MessagesDataSourceLocal {
  final String hiveListKey = "currentList";
  final String hiveBoxName = "dataLocatorBox";

  @override
  Future<List<Message>> loadMessagesDb() async {
    try {
      final Box hiveDB = await Hive.openBox(hiveBoxName);
      List dataReturned = hiveDB.get(hiveListKey, defaultValue: []);
      return dataReturned.map<Message>((recordJson) => Message.fromJson(json.decode(recordJson))).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveMessagesDb(List<Message> records) async {
    try {
      final Box hiveDB = await Hive.openBox(hiveBoxName);
      if (records.isNotEmpty) {
        List<String> toJsonList = records.map<String>((e) => json.encode(e.toJson())).toList();
        await hiveDB.put(hiveListKey, toJsonList);
      } else {
        await hiveDB.put(hiveListKey, []);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

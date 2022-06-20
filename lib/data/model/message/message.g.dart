// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['sid'] as String?,
      date: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      phoneNumber: json['to'] as String?,
      messageBody: json['body'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'sid': instance.id,
      'dateCreated': instance.date?.toIso8601String(),
      'to': instance.phoneNumber,
      'body': instance.messageBody,
    };

import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'sid')
  final String? id;
  @JsonKey(name: 'dateCreated')
  final DateTime? date;
  @JsonKey(name: 'to')
  final String? phoneNumber;
  @JsonKey(name: 'body')
  final String? messageBody;

  Message({this.id, this.date, this.phoneNumber, this.messageBody});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

// flutter pub run build_runner build
// flutter pub run build_runner watch
//flutter pub run build_runner build --delete-conflicting-outputs


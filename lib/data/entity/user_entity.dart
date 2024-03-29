import 'dart:convert';

import 'package:may/generated/json/base/json_field.dart';
import 'package:may/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String? id;
  String? name;
  String? age;
  String? phone;
  int countNum = 0;

  UserEntity({
    this.id,
    this.name,
    this.age,
    this.phone,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  factory UserEntity.empty() {
    return UserEntity(phone: "0123456789");
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

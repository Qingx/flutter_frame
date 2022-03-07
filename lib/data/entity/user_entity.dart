import 'dart:convert';
import 'package:qinghe_ios/generated/json/base/json_field.dart';
import 'package:qinghe_ios/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {

	String? id;
	String? name;
	String? age;
  
  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
import 'package:may/generated/json/base/json_convert_content.dart';
import 'package:may/data/entity/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
	final UserEntity userEntity = UserEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userEntity.name = name;
	}
	final String? age = jsonConvert.convert<String>(json['age']);
	if (age != null) {
		userEntity.age = age;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		userEntity.phone = phone;
	}
	return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['age'] = entity.age;
	data['phone'] = entity.phone;
	return data;
}
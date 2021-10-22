// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return UserProfileModel(
    id: json['id'] as int,
    name: json['name'] as String,
    surname: json['surname'] as String,
    gender: json['gender'] as String,
    idNumber: json['idNumber'] as String,
    cellNumber: json['cellNumber'] as String,
    emailAddress: json['emailAddress'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'idNumber': instance.idNumber,
      'cellNumber': instance.cellNumber,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DependentModel _$DependentModelFromJson(Map<dynamic, dynamic> json) {
  return DependentModel(
    id: json['id'] ,
    name: json['name'] as String,
    surname: json['surname'] as String,
    cellNumber: json['cellNumber'] as String,
  );
}

Map<String, dynamic> _$DependentModelToJson(DependentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cellNumber': instance.cellNumber,
    };

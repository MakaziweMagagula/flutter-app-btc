// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependentViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DependentViewModel _$DependentViewModelFromJson(Map<String, dynamic> json) {
  return DependentViewModel(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DependentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DependentViewModelToJson(DependentViewModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

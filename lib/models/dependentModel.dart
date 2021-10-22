import 'package:json_annotation/json_annotation.dart';

part 'dependentModel.g.dart';

@JsonSerializable()
class DependentModel {
  int id;
  String name;
  String surname;
  String cellNumber;

  DependentModel({this.name, this.surname, this.cellNumber, this.id});

  factory DependentModel.fromJson(Map<String, dynamic> json) =>
      _$DependentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DependentModelToJson(this);
}

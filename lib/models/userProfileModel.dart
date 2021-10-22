import 'package:json_annotation/json_annotation.dart';

part 'userProfileModel.g.dart';

@JsonSerializable()
class UserProfileModel {
  int id;
  String name;
  String surname;
  String gender;
  String idNumber;
  String cellNumber;
  String emailAddress;
  String password;

  UserProfileModel({this.id, this.name, this.surname, this.gender, this.idNumber, this.cellNumber, this.emailAddress, this.password});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

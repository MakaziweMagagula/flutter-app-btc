import 'package:gbv_break_the_cycle/models/dependentModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dependentViewModel.g.dart';

@JsonSerializable()
class DependentViewModel {
  List<DependentModel> data;
  DependentViewModel({this.data});
  factory DependentViewModel.fromJson(Map<String, dynamic> json) =>
      _$DependentViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$DependentViewModelToJson(this);
}
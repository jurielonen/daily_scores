import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_model.freezed.dart';
part 'name_model.g.dart';

@freezed
class NameModel with _$NameModel {
  const factory NameModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'default') String? value,
  }) = _NameModel;

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);
}

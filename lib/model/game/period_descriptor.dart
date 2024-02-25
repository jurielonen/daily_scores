import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_descriptor.freezed.dart';
part 'period_descriptor.g.dart';

@freezed
class PeriodDescriptor with _$PeriodDescriptor {
  const factory PeriodDescriptor(
      {required int number, required String periodType}) = _PeriodDescriptor;

  factory PeriodDescriptor.fromJson(Map<String, dynamic> json) =>
      _$PeriodDescriptorFromJson(json);
}

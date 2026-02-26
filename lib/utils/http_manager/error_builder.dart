import 'package:json_annotation/json_annotation.dart';

part 'error_builder.g.dart';

@JsonSerializable()
class ErrorBuilder {
  final int code;
  final String msg;
  final Object? more;
  ErrorBuilder({required this.msg, required this.code, this.more});

  factory ErrorBuilder.fromJson(Map<String, dynamic> json) =>
      _$ErrorBuilderFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorBuilderToJson(this);
}

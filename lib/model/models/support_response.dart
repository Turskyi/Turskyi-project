import 'package:json_annotation/json_annotation.dart';

part 'support_response.g.dart';

@JsonSerializable()
class SupportResponse {
  const SupportResponse({required this.success, required this.message});

  factory SupportResponse.fromJson(final Map<String, dynamic> json) =>
      _$SupportResponseFromJson(json);

  final bool success;
  final String message;

  Map<String, Object?> toJson() => _$SupportResponseToJson(this);
}

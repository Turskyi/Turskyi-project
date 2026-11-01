import 'package:json_annotation/json_annotation.dart';

part 'support_form_data.g.dart';

@JsonSerializable()
class SupportFormData {
  const SupportFormData({
    required this.name,
    required this.email,
    required this.message,
  });

  factory SupportFormData.fromJson(final Map<String, dynamic> json) =>
      _$SupportFormDataFromJson(json);

  final String name;
  final String email;
  final String message;

  SupportFormData copyWith({
    final String? name,
    final String? email,
    final String? message,
  }) {
    return SupportFormData(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  Map<String, Object?> toJson() => _$SupportFormDataToJson(this);
}

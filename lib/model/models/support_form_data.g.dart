// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportFormData _$SupportFormDataFromJson(Map<String, dynamic> json) =>
    SupportFormData(
      name: json['name'] as String,
      email: json['email'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SupportFormDataToJson(SupportFormData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
    };

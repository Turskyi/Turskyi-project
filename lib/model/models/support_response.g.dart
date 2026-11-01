// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportResponse _$SupportResponseFromJson(Map<String, dynamic> json) =>
    SupportResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SupportResponseToJson(SupportResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

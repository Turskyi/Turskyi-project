// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_health_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlHealthResponse _$UrlHealthResponseFromJson(Map<String, dynamic> json) =>
    UrlHealthResponse(
      available: json['available'] as bool,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$UrlHealthResponseToJson(UrlHealthResponse instance) =>
    <String, dynamic>{
      'available': instance.available,
      'statusCode': instance.statusCode,
      'error': instance.error,
    };

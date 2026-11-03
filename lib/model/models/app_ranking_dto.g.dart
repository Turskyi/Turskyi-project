// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_ranking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppRankingDto _$AppRankingDtoFromJson(Map<String, dynamic> json) =>
    AppRankingDto(
      id: json['id'] as String,
      total: (json['total'] as num).toInt(),
      ios: (json['ios'] as num).toInt(),
      android: (json['android'] as num).toInt(),
      web: (json['web'] as num).toInt(),
    );

Map<String, dynamic> _$AppRankingDtoToJson(AppRankingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'ios': instance.ios,
      'android': instance.android,
      'web': instance.web,
    };

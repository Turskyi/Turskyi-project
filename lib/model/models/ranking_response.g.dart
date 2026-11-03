// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    RankingResponse(
      updatedAt: json['updatedAt'] as String,
      apps: (json['apps'] as List<dynamic>)
          .map((e) => AppRankingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      subrequestsCount: (json['subrequestsCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RankingResponseToJson(RankingResponse instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'apps': instance.apps,
      'subrequestsCount': instance.subrequestsCount,
    };

import 'package:json_annotation/json_annotation.dart';

part 'app_ranking_dto.g.dart';

@JsonSerializable()
class AppRankingDto {
  const AppRankingDto({
    required this.id,
    required this.total,
    required this.ios,
    required this.android,
    required this.web,
  });

  factory AppRankingDto.fromJson(final Map<String, Object?> json) {
    return _$AppRankingDtoFromJson(json);
  }

  final String id;
  final int total;
  final int ios;
  final int android;
  final int web;

  Map<String, Object?> toJson() => _$AppRankingDtoToJson(this);
}

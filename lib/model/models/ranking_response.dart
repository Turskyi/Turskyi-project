import 'package:json_annotation/json_annotation.dart';
import 'package:turskyi/model/models/app_ranking_dto.dart';

part 'ranking_response.g.dart';

@JsonSerializable()
class RankingResponse {
  const RankingResponse({
    required this.updatedAt,
    required this.apps,
    this.subrequestsCount = 0,
  });

  factory RankingResponse.fromJson(final Map<String, Object?> json) {
    return _$RankingResponseFromJson(json);
  }

  final String updatedAt;
  final List<AppRankingDto> apps;
  final int subrequestsCount;

  Map<String, Object?> toJson() => _$RankingResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'url_health_response.g.dart';

/// [UrlHealthResponse] represents the result of a server-side URL health
/// check returned by the Cloudflare Worker backend.
///
/// - [statusCode] is nullable (`int?`) because it is only populated when
///   an HTTP response is successfully received from the target URL
///   (e.g., 200, 404, 500). It is `null` when a complete network or DNS
///   failure prevents an HTTP response.
/// - [error] is nullable (`String?`) because it is only populated when a
///   network or DNS exception occurs during the fetch. It is `null` when
///   an HTTP response is successfully received.
@JsonSerializable()
class UrlHealthResponse {
  const UrlHealthResponse({
    required this.available,
    this.statusCode,
    this.error,
  });

  factory UrlHealthResponse.fromJson(final Map<String, Object?> json) {
    return _$UrlHealthResponseFromJson(json);
  }

  final bool available;
  final int? statusCode;
  final String? error;

  Map<String, Object?> toJson() => _$UrlHealthResponseToJson(this);
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turskyi/model/models/support_form_data.dart';
import 'package:turskyi/model/models/support_response.dart';
import 'package:turskyi/model/models/url_health_response.dart';
import 'package:turskyi/res/constants.dart' as constants;

part 'support_api_client.g.dart';

/// [SupportApiClient] defines the REST API endpoints for the Cloudflare Worker
/// backend.
/// Base URL: https://turskyi-support-api.dmytro-turskyi.workers.dev
@RestApi(baseUrl: constants.kSupportWorkerBaseUrl)
abstract class SupportApiClient {
  factory SupportApiClient(final Dio dio, {final String baseUrl}) =
      _SupportApiClient;

  /// Sends a support message email via Resend.
  ///
  /// **Postman / cURL Example:**
  /// - **Method:** `POST`
  /// - **URL:** `https://turskyi-support-api.dmytro-turskyi.workers.dev/support`
  /// - **Headers:** `Content-Type: application/json`
  /// - **Body (JSON):**
  ///   ```json
  ///   {
  ///     "name": "John Doe",
  ///     "email": "john@example.com",
  ///     "message": "Hello from Postman!"
  ///   }
  ///   ```
  /// - **Response (200 OK):**
  ///   ```json
  ///   {
  ///     "success": true,
  ///     "message": "Email sent successfully"
  ///   }
  ///   ```
  @POST('/support')
  Future<SupportResponse> sendSupportEmail(
    @Body() final SupportFormData formData,
  );

  /// Checks the health/reachability of a given URL.
  ///
  /// **Postman / cURL Example:**
  /// - **Method:** `GET`
  /// - **URL:** `https://turskyi-support-api.dmytro-turskyi.workers.dev/health?url=https://google.com`
  /// - **Response (200 OK):**
  ///   ```json
  ///   {
  ///     "available": true,
  ///     "statusCode": 200
  ///   }
  ///   ```
  @GET('/health')
  Future<UrlHealthResponse> checkUrlHealth(@Query('url') final String url);
}

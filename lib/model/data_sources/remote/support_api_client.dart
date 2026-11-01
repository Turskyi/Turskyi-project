import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turskyi/model/models/support_form_data.dart';
import 'package:turskyi/model/models/support_response.dart';
import 'package:turskyi/res/constants.dart' as constants;

part 'support_api_client.g.dart';

@RestApi(baseUrl: constants.kSupportWorkerBaseUrl)
abstract class SupportApiClient {
  factory SupportApiClient(final Dio dio, {final String baseUrl}) =
      _SupportApiClient;

  @POST('/support')
  Future<SupportResponse> sendSupportEmail(
    @Body() final SupportFormData formData,
  );
}

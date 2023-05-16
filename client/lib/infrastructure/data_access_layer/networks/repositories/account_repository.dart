import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';
import 'package:chat_app/infrastructure/commons/extensions/error_type_extension.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/api_response.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/api_response_provider.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/application_error.dart';
import 'package:chat_app/infrastructure/models/response/coins_response.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> getCoinsData({required String searchText}) async {
    final getCoinsDataUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=$searchText,';
    final uri = Uri.parse(getCoinsDataUrl);

    APIResponse result = await _apiResponseProvider.get(
      uri,
      headers: {"X-CMC_PRO_API_KEY": "27ab17d1-215f-49e5-9ca4-afd48810c149"},
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var getCoinsDataResponse = await compute(CoinsResponse.parseInfo, result.response);
        return ApiHttpResult.success(getCoinsDataResponse);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }
}

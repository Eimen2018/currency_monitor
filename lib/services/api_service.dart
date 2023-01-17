import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/constants/app_constants.dart';
import 'package:currency_monitor/exceptions/api_exceptions.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/models/latest_rates/latest_rates.dart';

import 'http_service.dart';

class ApiService {
  final _httpService = locator<HttpService>();

/// > It makes a GET request to the `kLatestRatesUrl` endpoint, and if the response is successful, it
/// returns a `LatestRates` object
/// 
/// Returns:
///   LatestRates
  Future<LatestRates> fetchLatestRates() async {
    final response = await _httpService.get(kLatestRatesUrl);

    if (response.statusCode == 200) {
      return LatestRates.fromJson(response.data!);
    }

    throw ApiException(
      'Error getting latest rates',
      statusCode: response.statusCode,
      detail: response.statusMessage,
    );
  }

/// It makes a GET request to the `kCurrenciesUrl` endpoint, and if the response is successful, it
/// returns a list of `Currency` objects
/// 
/// Returns:
///   A list of currencies.
  Future<List<Currency>> fetchCurrencies() async {
    final response = await _httpService.get(kCurrenciesUrl);

    if (response.statusCode == 200) {
      return (response.data! as Map<String, dynamic>)
          .entries
          .map<Currency>((e) => Currency(code: e.key, name: e.value))
          .toList();
    }

    throw ApiException(
      'Error getting currencies',
      statusCode: response.statusCode,
      detail: response.statusMessage,
    );
  }
}

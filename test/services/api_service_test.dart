import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ApiServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('fetchLatestRates -', () {
      test('when called should recieve latest rates', () async {
        final service = ApiService();
        final result = await service.fetchLatestRates();
        expect(result.rates?.isNotEmpty, true);
      });
    });
    group('fetchCurrencies -', () {
      test('when called should recieve latest rates', () async {
        final service = ApiService();
        final result = await service.fetchCurrencies();
        expect(result.isNotEmpty, true);
      });
    });
  });
}

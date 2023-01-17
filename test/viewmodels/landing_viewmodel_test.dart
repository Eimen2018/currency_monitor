import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/ui/views/landing/landing_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LandingViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('fetchLatestRates -', () {
      test('when initialized should call api to fetch latest rates', () {
        final service = getAndRegisterApiService();
        final model = LandingViewModel();
        model.initialise();
        verify(service.fetchLatestRates()).called(1);
      });

      test('when there is error in fetching, model hasError should be true',
          () async {
        getAndRegisterApiService(hasError: true);
        final model = LandingViewModel();
        await model.initialise();
        expect(model.hasError, true);
      });
    });
    group('removeCurrency -', () {
      test('when called should remove currency from shared preferences', () {
        final service = getAndRegisterSharedPreferencesService(
          monitoredCurrencies: [
            Currency(code: 'USD', name: 'US Dollar'),
            Currency(code: 'EUR', name: 'Euro'),
          ],
        );
        final model = LandingViewModel();
        model.removeCurrency(Currency(code: 'USD', name: 'US Dollar'));
        expect(service.monitoredCurrencies.length, 1);
      });
    });
  });
}

import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/ui/views/add_currency/add_currency_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AddCurrencyViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('initialise -', () {
      test('when called should get currencies from api', () {
        final service = getAndRegisterApiService();
        final model = AddCurrencyViewModel();
        model.initialise();
        verify(service.fetchCurrencies()).called(1);
      });
      test('when there is error in fetching, model hasError should be true',
          () async {
        getAndRegisterApiService(hasError: true);
        final model = AddCurrencyViewModel();
        await model.initialise();
        expect(model.hasError, true);
      });
    });

    group('saveAndNavigateBack -', () {
      test('when called should add currency to selectedCurrencies', () {
        final model = AddCurrencyViewModel();
        model.selectCurrency(Currency(code: 'USD', name: 'US Dollar'));
        expect(model.selectedCurrency.length, 1);
      });
      test('when called should add currency to sharedPreferences', () {
        final service = getAndRegisterSharedPreferencesService();
        final model = AddCurrencyViewModel();
        model.selectCurrency(Currency(code: 'USD', name: 'US Dollar'));
        model.saveAndNavigateBack();
        verify(service.monitoredCurrencies);
      });
      test('when called should navigate back', () {
        final navigationService = getAndRegisterNavigationService();
        final model = AddCurrencyViewModel();
        model.selectCurrency(Currency(code: 'USD', name: 'US Dollar'));
        model.saveAndNavigateBack();
        verify(navigationService.back());
      });
    });
  });
}

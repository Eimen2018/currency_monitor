import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/constants/app_constants.dart';
import 'package:currency_monitor/ui/bottom_sheets/currency_converter/currency_converter_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CurrencyConverterTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('calculateRate -', () {
      test(
          'when called should calculate rate and update _afterMarkUpConversion',
          () {
        const rate = 3.67;
        final model = CurrencyConverterModel(rate: rate);
        model.setData({'amount': '10.0'});
        final amount = double.parse(model.formValueMap['amount']);
        model.calculateRate(model.formValueMap['amount']);
        expect(model.afterMarkUpConversion,
            amount * rate + (amount * rate * (kMarkUpPercentage / 100)));
      });
      test(
          'when swapped, should calculate invertly and update _afterMarkUpConversion',
          () {
        const rate = 3.67;
        final model = CurrencyConverterModel(rate: rate);
        model.setData({'amount': '10.0'});
        final amount = double.parse(model.formValueMap['amount']);
        model.swap();
        expect(
            model.afterMarkUpConversion,
            amount * (1 / rate) +
                (amount * (1 / rate) * (kMarkUpPercentage / 100)));
      });
    });
  });
}

import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/constants/app_constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'currency_converter.form.dart';

class CurrencyConverterModel extends FormViewModel {
  final _dialogService = locator<DialogService>();

  final double rate;
  CurrencyConverterModel({required this.rate});

  bool _swapped = false;
  bool get swapped => _swapped;

  double _afterMarkUpConversion = 0.0;
  double get afterMarkUpConversion => _afterMarkUpConversion;

  Future<bool> confirmDelete() async {
    final result = await _dialogService.showConfirmationDialog(
      confirmationTitle: 'Remove',
      title: 'Remove Currency',
      description: 'Are you sure you want to remove this currency?',
      cancelTitle: 'Cancel',
    );
    return result?.confirmed ?? false;
  }

  void swap() {
    _swapped = !_swapped;
    calculateRate(amountValue);
    notifyListeners();
  }

  /// If the value is not null, then convert it to a double, otherwise, set it to 0.0
  ///
  /// Args:
  ///   value (String): The value of the input field.
  void calculateRate(String? value) {
    final double? amount = double.tryParse(value ?? '0.0');
    final netConversion = (amount ?? 0.0) * (_swapped ? 1 / rate : rate);
    _afterMarkUpConversion =
        netConversion + (netConversion * (kMarkUpPercentage / 100));
    notifyListeners();
  }

  @override
  void setFormStatus() {
    calculateRate(amountValue);
    super.setFormStatus();
  }
}

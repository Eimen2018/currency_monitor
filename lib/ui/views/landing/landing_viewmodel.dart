import 'package:currency_monitor/app/app.bottomsheets.dart';
import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/app/app.router.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/models/latest_rates/latest_rates.dart';
import 'package:currency_monitor/services/api_service.dart';
import 'package:currency_monitor/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _sharedPreferenceService = locator<SharedPreferencesService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Currency> get monitoredCurrencies =>
      _sharedPreferenceService.monitoredCurrencies;

  LatestRates get latestRates => skeletonData(
        realData: data,
        busyData: LatestRates(timestamp: DateTime.now().millisecondsSinceEpoch),
      );

  void navigateToAddCurrencyView() async {
    await _navigationService.navigateToAddCurrencyView();
    notifyListeners();
  }

  void removeCurrency(Currency currency) {
    _sharedPreferenceService.monitoredCurrencies = _sharedPreferenceService
        .monitoredCurrencies
      ..removeWhere((element) => element.code == currency.code);
    notifyListeners();
  }

  void showCurrencyConverter(Currency currency) async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomsheetType.currencyConverter,
      title: currency.code,
      description: currency.name,
      data: currency.rate,
    );
    if (result?.confirmed ?? false) {
      removeCurrency(currency);
    }
  }

  @override
  Future futureToRun() => _apiService.fetchLatestRates();
}

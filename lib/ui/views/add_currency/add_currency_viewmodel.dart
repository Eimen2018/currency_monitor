import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/services/api_service.dart';
import 'package:currency_monitor/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddCurrencyViewModel extends FutureViewModel<List<Currency>> {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPreferenceService = locator<SharedPreferencesService>();

  final List<Currency> selectedCurrency = [];

  bool get isMultipleSelection => selectedCurrency.isNotEmpty;

  String? _search;
  String? get search => _search;

  List<Currency> get currencies => skeletonData(
        realData: (search?.isNotEmpty ?? false) ? filteredCurrencies : data,
        busyData: List.filled(10, Currency(code: '', name: '')),
      );

  List<Currency> get filteredCurrencies =>
      data
          ?.where((currency) => currency.toJson().values.any((element) =>
              (element is String)
                  ? element.toLowerCase().contains(search?.toLowerCase() ?? '')
                  : false))
          .toList() ??
      [];

  void setSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  void selectCurrency(Currency currency) {
    if (selectedCurrency.contains(currency)) {
      selectedCurrency.remove(currency);
    } else {
      selectedCurrency.add(currency);
    }
    notifyListeners();
  }

  void saveAndNavigateBack() {
    _sharedPreferenceService.monitoredCurrencies = [
      ..._sharedPreferenceService.monitoredCurrencies,
      ...selectedCurrency
    ];
    _navigationService.back();
  }

  @override
  void onData(List<Currency>? data) {
    data?.removeWhere(
      (element) =>
          _sharedPreferenceService.monitoredCurrencies
              .any((currency) => currency.code == element.code) ||
          element.code == 'USD',
    );
    super.onData(data);
  }

  @override
  Future<List<Currency>> futureToRun() => _apiService.fetchCurrencies();
}

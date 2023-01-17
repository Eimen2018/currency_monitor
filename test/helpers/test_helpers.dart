import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/constants/app_constants.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/models/latest_rates/latest_rates.dart';
import 'package:currency_monitor/services/api_service.dart';
import 'package:currency_monitor/services/http_service.dart';
import 'package:currency_monitor/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HttpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SharedPreferencesService>(
      onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterApiService();
  getAndRegisterHttpService();
  getAndRegisterSharedPreferencesService();
  // @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  when(service.back(result: anyNamed('result'), id: anyNamed('id')))
      .thenReturn(false);
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockApiService getAndRegisterApiService({bool hasError = false}) {
  _removeRegistrationIfExists<ApiService>();
  final service = MockApiService();
  when(service.fetchLatestRates()).thenAnswer((realInvocation) async {
    if (hasError) {
      throw Exception();
    } else {
      return LatestRates(timestamp: 0, base: '', rates: {});
    }
  });
  when(service.fetchCurrencies()).thenAnswer((realInvocation) async {
    if (hasError) {
      throw Exception();
    } else {
      return <Currency>[];
    }
  });
  locator.registerSingleton<ApiService>(service);
  return service;
}

MockHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<HttpService>();
  final service = MockHttpService();
  when(service.get(kLatestRatesUrl)).thenAnswer((realInvocation) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'rates': {
          "AED": 3.67,
          "AFN": 77.0,
          "ALL": 102.0,
        }
      },
      statusCode: 200,
    );
  });
  when(service.get(kCurrenciesUrl)).thenAnswer((realInvocation) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: {
        "AED": "United Arab Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek",
      },
      statusCode: 200,
    );
  });
  locator.registerSingleton<HttpService>(service);
  return service;
}

MockSharedPreferencesService getAndRegisterSharedPreferencesService(
    {List<Currency> monitoredCurrencies = const []}) {
  _removeRegistrationIfExists<SharedPreferencesService>();
  final service = MockSharedPreferencesService();
  when(service.monitoredCurrencies)
      .thenAnswer((realInvocation) => monitoredCurrencies);

  locator.registerSingleton<SharedPreferencesService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

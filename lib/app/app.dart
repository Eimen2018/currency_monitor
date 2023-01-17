import 'package:currency_monitor/services/api_service.dart';
import 'package:currency_monitor/services/http_service.dart';
import 'package:currency_monitor/services/shared_preferences_service.dart';
import 'package:currency_monitor/ui/bottom_sheets/currency_converter/currency_converter.dart';
import 'package:currency_monitor/ui/views/add_currency/add_currency_view.dart';
import 'package:currency_monitor/ui/views/landing/landing_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: LandingView, initial: true),
    MaterialRoute(page: AddCurrencyView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: HttpService),
    LazySingleton(classType: ApiService),
    Presolve(
      classType: SharedPreferencesService,
      presolveUsing: SharedPreferencesService.getInstance,
    )
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: CurrencyConverter),
  ],
  logger: StackedLogger(),
)
class App {}

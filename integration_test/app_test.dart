import 'package:currency_monitor/app/app.locator.dart';
import 'package:currency_monitor/main.dart' as app;
import 'package:currency_monitor/services/shared_preferences_service.dart';
import 'package:currency_monitor/ui/views/landing/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Adding one currency flow', (tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      await app.main();
      locator<SharedPreferencesService>().clearPreferences();

      await tester.pumpAndSettle();
      final monitoredCurrencyItem = find.byType(MonitoredCurrencyItem);

      expect(monitoredCurrencyItem, findsNothing);

      /// navigate to add currency view
      await tester.tap(find.byType(FloatingActionButton));

      await tester.pump(const Duration(seconds: 2));
      tester.printToConsole('Tapping on the first item');
      await tester.tap(find.byType(ListTile).first);
      await tester.pump();
      await tester.pump();

      expect(monitoredCurrencyItem, findsOneWidget);

      // remove currency
      await tester.drag(find.byType(Dismissible).first, const Offset(-200, 0));

      await tester.pumpAndSettle();
      expect(monitoredCurrencyItem, findsNothing);
    });
  });
}

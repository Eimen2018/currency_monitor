// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/bottom_sheets/currency_converter/currency_converter.dart';

enum BottomsheetType {
  currencyConverter,
}

void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomSheetService>();

  final builders = {
    BottomsheetType.currencyConverter: (context, SheetRequest request,
            void Function(SheetResponse) completer) =>
        CurrencyConverter(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}

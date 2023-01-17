import 'package:currency_monitor/constants/app_constants.dart';
import 'package:currency_monitor/ui/bottom_sheets/currency_converter/currency_converter_model.dart';
import 'package:currency_monitor/ui/common/app_colors.dart';
import 'package:currency_monitor/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'currency_converter.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'amount'),
  ],
)
class CurrencyConverter extends StackedView<CurrencyConverterModel>
    with $CurrencyConverter {
  final SheetRequest<dynamic> request;
  final Function(SheetResponse) completer;
  CurrencyConverter({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  void onViewModelReady(CurrencyConverterModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(CurrencyConverterModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, CurrencyConverterModel viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            verticalSpaceSmall,
            Row(
              children: [
                IconButton(
                  onPressed: () => completer(SheetResponse()),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: kcWhite,
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.swapped
                      ? '${request.title} to USD Converter'
                      : 'USD to ${request.title} Converter',
                  style: const TextStyle(
                    fontSize: 18,
                    color: kcWhite,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    final result = await viewModel.confirmDelete();
                    if (result) {
                      completer(SheetResponse(confirmed: result));
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: kcPrimaryColor,
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                viewModel.swapped ? request.title! : 'USD',
                style: const TextStyle(
                  color: kcWhite,
                  fontSize: 20,
                ),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: kcWhite,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: kcWhite,
                fontSize: 30,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                /// Money input formatter
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
            ),
            verticalSpaceSmall,
            IconButton(
              tooltip: 'Swap Currencies',
              onPressed: viewModel.swap,
              icon: const Icon(
                Icons.swap_vert,
                size: 30,
                color: kcPrimaryColor,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                viewModel.swapped ? 'USD' : request.title!,
                style: const TextStyle(
                  color: kcWhite,
                  fontSize: 20,
                ),
              ),
            ),
            verticalSpaceSmall,
            Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: kcMediumGrey.withOpacity(0.4),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                viewModel.afterMarkUpConversion.toStringAsFixed(2),
                style: const TextStyle(
                  color: kcWhite,
                  fontSize: 30,
                ),
              ),
            ),
            verticalSpaceMedium,
            Container(
              alignment: Alignment.center,
              child: Text(
                viewModel.swapped
                    ? '1 ${request.title} = ${(1 / viewModel.rate).toStringAsFixed(2)} USD'
                    : '1 USD = ${viewModel.rate} ${request.title}',
                style: const TextStyle(
                  color: kcLightGrey,
                  fontSize: 16,
                ),
              ),
            ),
            verticalSpaceTiny,
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Conversions are calculated with a $kMarkUpPercentage% markup',
                style: TextStyle(
                  color: kcLightGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CurrencyConverterModel viewModelBuilder(BuildContext context) =>
      CurrencyConverterModel(rate: request.data);
}

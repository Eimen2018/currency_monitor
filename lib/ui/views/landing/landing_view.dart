import 'package:currency_monitor/constants/app_constants.dart';
import 'package:currency_monitor/models/currency/currency.dart';
import 'package:currency_monitor/ui/common/app_colors.dart';
import 'package:currency_monitor/ui/common/ui_helpers.dart';
import 'package:currency_monitor/ui/widgets/dumb_widgets/custom_skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'landing_viewmodel.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LandingViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Monitor'.toUpperCase()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.navigateToAddCurrencyView,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            if (viewModel.monitoredCurrencies.isEmpty) ...[
              const Spacer(),
              verticalSpaceMedium,
              const Center(
                child: Text(
                  'No currencies added\nTap the + button to add a currency',
                  style: TextStyle(
                    color: kcVeryLightGrey,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
            ],
            if (viewModel.monitoredCurrencies.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rate Updated'.toUpperCase(),
                              style: const TextStyle(color: kcWhite),
                            ),
                            CustomSkeletonLoader(
                              isLoading: viewModel.isBusy,
                              child: Text(
                                viewModel.latestRates.duration,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        children: [
                          Text(
                            'Monitored Currencies'.toUpperCase(),
                            style: const TextStyle(color: kcWhite),
                          ),
                          const Spacer(),
                          const Text(
                            'Swipe to remove',
                            style: TextStyle(color: kcWhite),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      ...viewModel.monitoredCurrencies.map((currency) {
                        return MonitoredCurrencyItem(currency: currency);
                      })
                    ],
                  ),
                ),
              ),
            Container(
              color: kcDarkGreyColor,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.network(
                kMukuruLogoUrl,
                errorBuilder: (context, error, stackTrace) => const Text(
                  'Mukuru',
                  style: TextStyle(
                    color: kcPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LandingViewModel viewModelBuilder(BuildContext context) => LandingViewModel();
}

class MonitoredCurrencyItem extends ViewModelWidget<LandingViewModel> {
  final Currency currency;
  const MonitoredCurrencyItem({
    Key? key,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LandingViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: CustomSkeletonLoader(
        isLoading: viewModel.isBusy,
        child: Dismissible(
          onDismissed: (direction) {
            viewModel.removeCurrency(currency);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(
              Icons.delete,
              color: kcWhite,
            ),
          ),
          key: Key(currency.code),
          child: ListTile(
            enableFeedback: true,
            title: Text(
              currency.code,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              viewModel.showCurrencyConverter(
                currency.copyWith(
                  rate: viewModel.latestRates.rates?[currency.code],
                ),
              );
            },
            subtitle: Text(currency.name),
            trailing: Container(
              color: kcPrimaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                '${viewModel.latestRates.rates?[currency.code]?.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kcWhite,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 24),
          ),
        ),
      ),
    );
  }
}

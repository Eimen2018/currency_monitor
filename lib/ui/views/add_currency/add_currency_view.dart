import 'package:currency_monitor/ui/common/app_colors.dart';
import 'package:currency_monitor/ui/common/ui_helpers.dart';
import 'package:currency_monitor/ui/widgets/dumb_widgets/custom_skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_currency_viewmodel.dart';

class AddCurrencyView extends StackedView<AddCurrencyViewModel> {
  const AddCurrencyView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AddCurrencyViewModel viewModel, Widget? child) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Add Currency'.toUpperCase(),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(color: kcWhite),
                  decoration: const InputDecoration(
                    hintText: 'Filter',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20,
                    ),
                  ),
                  onChanged: viewModel.setSearch,
                ),
              ),
            )),
        floatingActionButton: viewModel.isMultipleSelection
            ? FloatingActionButton.extended(
                onPressed: viewModel.saveAndNavigateBack,
                isExtended: true,
                label: Text(
                  'Add (${viewModel.selectedCurrency.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Tap a currency to add or long press to select multiple',
                      style: TextStyle(
                        color: kcVeryLightGrey,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 5,
                        color: kcDarkGreyColor,
                      ),
                      itemCount: viewModel.currencies.length,
                      itemBuilder: (context, index) {
                        final currency = viewModel.currencies[index];
                        return CustomSkeletonLoader(
                          key: Key('Currency$index'),
                          isLoading: viewModel.isBusy,
                          child: ListTile(
                            title: Text(
                              currency.code,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(currency.name),
                            trailing: const Icon(Icons.add),
                            onTap: () {
                              if (viewModel.isMultipleSelection) {
                                viewModel.selectCurrency(currency);
                                return;
                              }
                              viewModel.selectCurrency(currency);
                              viewModel.saveAndNavigateBack();
                            },
                            onLongPress: () =>
                                viewModel.selectCurrency(currency),
                            selected:
                                viewModel.selectedCurrency.contains(currency),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  AddCurrencyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddCurrencyViewModel();
}

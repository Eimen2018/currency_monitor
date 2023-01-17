// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String AmountValueKey = 'amount';

final Map<String, TextEditingController>
    _CurrencyConverterTextEditingControllers = {};

final Map<String, FocusNode> _CurrencyConverterFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CurrencyConverterTextValidations = {
  AmountValueKey: null,
};

mixin $CurrencyConverter on StatelessWidget {
  TextEditingController get amountController =>
      _getFormTextEditingController(AmountValueKey);
  FocusNode get amountFocusNode => _getFormFocusNode(AmountValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_CurrencyConverterTextEditingControllers.containsKey(key)) {
      return _CurrencyConverterTextEditingControllers[key]!;
    }
    _CurrencyConverterTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CurrencyConverterTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CurrencyConverterFocusNodes.containsKey(key)) {
      return _CurrencyConverterFocusNodes[key]!;
    }
    _CurrencyConverterFocusNodes[key] = FocusNode();
    return _CurrencyConverterFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    amountController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    amountController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AmountValueKey: amountController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        AmountValueKey: _getValidationMessage(AmountValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _CurrencyConverterTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_CurrencyConverterTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CurrencyConverterTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CurrencyConverterFocusNodes.values) {
      focusNode.dispose();
    }

    _CurrencyConverterTextEditingControllers.clear();
    _CurrencyConverterFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get amountValue => this.formValueMap[AmountValueKey] as String?;

  bool get hasAmount =>
      this.formValueMap.containsKey(AmountValueKey) &&
      (amountValue?.isNotEmpty ?? false);

  bool get hasAmountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey]?.isNotEmpty ?? false;

  String? get amountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey];
}

extension Methods on FormViewModel {
  setAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AmountValueKey] = validationMessage;
}

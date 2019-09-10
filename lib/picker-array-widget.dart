import 'dart:convert';

import 'package:field_array_picker/picker-array-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class PickerArrayWidget extends StatelessWidget {
  const PickerArrayWidget({
    Key key,
    @required this.controller,
    @required this.focusNode,
    @required this.options,
    @required this.title,
    @required this.inputDecoration,
    this.onFieldSubmitted,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<String> options;
  final Text title;
  final InputDecoration inputDecoration;
  final Function() onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return PickerArrayField(
      decoration: inputDecoration,
      controller: controller,
      options: options,
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        onFieldSubmitted();
      },
      onShowPicker: (context, currentValue) {
        Picker(
          adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert('[' + options.toString() + ']'),
            isArray: true,
          ),
          hideHeader: true,
          title: title,
          onConfirm: (Picker picker, List value) {
            controller.text = picker.getSelectedValues().toString().replaceAll(new RegExp(r'\['), '').replaceAll(new RegExp(r'\]'), '');
          }
        ).showDialog(context);
      },
    );
  }
}
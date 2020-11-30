import 'dart:io';

import 'package:attract_group_test/ui/screen/edit_screen/textfield/pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Mode {
  text,
  date,
}

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Function(DateTime date) onDatePick;
  final Function(String text) onSubmitted;
  final Mode mode;
  final TextInputAction inputAction;

  AdaptiveTextField({
    Key key,
    @required this.controller,
    this.focusNode,
    this.label = 'test',
    this.onDatePick,
    this.onSubmitted,
    this.mode = Mode.text,
    this.inputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return mode == Mode.text
          ? _buildAndroidTextField()
          : _buildAndroidPickerTextField(context);
    }

    return mode == Mode.text
        ? _buildIosTextField()
        : _buildIosPickerTextField(context);
  }

  Widget _buildAndroidTextField() {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      onSubmitted: onSubmitted,
      textInputAction: inputAction,
    );
  }

  Widget _buildAndroidPickerTextField(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        var selectedDateTime = await showAndroidPickers(context);
        if (selectedDateTime != null) {
          controller.text = selectedDateTime.toString();
        }
        onDatePick(selectedDateTime);
      },
    );
  }

  Widget _buildIosTextField() {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      placeholder: label,
      onSubmitted: onSubmitted,
    );
  }

  Widget _buildIosPickerTextField(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      placeholder: label,
      readOnly: true,
      suffix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.calendar_today_outlined,
          color: Colors.grey,
        ),
      ),
      onTap: () async {
        var selectedDateTime = await showIosPickeres(context);
        controller.text = selectedDateTime.toString();
        onDatePick(selectedDateTime);
      },
    );
  }
}

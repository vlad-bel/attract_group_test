import 'dart:io';

import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/ui/screen/edit_screen/photo_picker/photo_picker.dart';
import 'package:attract_group_test/ui/screen/edit_screen/textfield/pickers.dart';
import 'package:attract_group_test/ui/screen/edit_screen/textfield/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final Film film;

  const EditScreen({this.film});

  @override
  State<StatefulWidget> createState() {
    return _EditScreenState();
  }
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController;
  TextEditingController dateController;
  TextEditingController descriptionController;

  File photo;

  final nameFocusNode = FocusNode();
  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  var formsIsValid = false;

  @override
  Widget build(BuildContext context) {
    return _buildAndroidUi();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.film?.name ?? '');
    dateController =
        TextEditingController(text: widget.film?.time.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.film?.description ?? '');

    ///add validator
    nameController.addListener(() {
      setState(() {
        formsIsValid = _validateFields();
      });
    });

    descriptionController.addListener(() {
      setState(() {
        formsIsValid = _validateFields();
      });
    });

    dateController.addListener(() {
      setState(() {
        formsIsValid = _validateFields();
      });
    });
  }

  bool _validateFields() {
    if (widget.film == null) {
      if ((nameController.text == null || nameController.text.isEmpty) ||
          (dateController.text == null || dateController.text.isEmpty) ||
          (descriptionController.text == null ||
              descriptionController.text.isEmpty) ||
          photo == null) {
        return false;
      } else {
        return true;
      }
    } else {
      if (nameController.text != widget.film.name ||
          dateController.text != widget.film.time.toString() ||
          descriptionController.text != widget.film.description) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dateController.dispose();
    descriptionController.dispose();

    nameFocusNode.dispose();
    dateFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  Widget _buildAndroidUi() {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPhotoPicker(),
              _buildTextFields(),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    if (Platform.isAndroid) {
      return AppBar(
        title: Text(widget.film != null ? "Edit film" : "Create new film"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      );
    }

    return CupertinoNavigationBar(
      middle: Text(widget.film != null ? "Edit film" : "Create new film"),
      leading: CupertinoButton(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return PhotoPicker(
      onImagePick: (File file) {
        setState(() {
          photo = file;
          formsIsValid = _validateFields();
        });
      },
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        AdaptiveTextField(
          controller: nameController,
          focusNode: nameFocusNode,
          label: "Film name",
          onSubmitted: (text) async {
            FocusScope.of(context).requestFocus(dateFocusNode);
            var selectedDateTime = Platform.isAndroid
                ? await showAndroidPickers(context)
                : showIosPickeres(context);
            if (selectedDateTime != null) {
              dateController.text = selectedDateTime.toString();
            }
            FocusScope.of(context).requestFocus(descriptionFocusNode);
          },
        ),
        SizedBox(
          height: 16,
        ),
        AdaptiveTextField(
          controller: dateController,
          focusNode: dateFocusNode,
          label: "film date",
          mode: Mode.date,
          onDatePick: (date) {
            FocusScope.of(context).requestFocus(descriptionFocusNode);
          },
        ),
        SizedBox(
          height: 16,
        ),
        AdaptiveTextField(
          controller: descriptionController,
          focusNode: descriptionFocusNode,
          label: "film description",
          inputAction: TextInputAction.done,
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(null);
          },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    if (Platform.isAndroid) {
      return Container(
        height: 48,
        width: double.infinity,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          onPressed: formsIsValid
              ? () {
                  if (widget.film == null) {
                    print("create");
                    return;
                  }
                  print('update');
                }
              : null,
          child: Text(
            widget.film == null ? 'Create' : "Update",
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: formsIsValid
            ? () {
                if (widget.film == null) {
                  print("create");
                  return;
                }
                print('update');
              }
            : null,
        child: Text(
          widget.film == null ? 'Create' : "Update",
        ),
      ),
    );
  }
}

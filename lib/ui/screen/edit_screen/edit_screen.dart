import 'dart:io';

import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/main.dart';
import 'package:attract_group_test/ui/screen/edit_screen/bloc/edit_screen_bloc.dart';
import 'package:attract_group_test/ui/screen/edit_screen/bloc/edit_screen_event.dart';
import 'package:attract_group_test/ui/screen/edit_screen/bloc/edit_screen_state.dart';
import 'package:attract_group_test/ui/screen/edit_screen/confirm_button/confirm_button.dart';
import 'package:attract_group_test/ui/screen/edit_screen/photo_picker/photo_picker.dart';
import 'package:attract_group_test/ui/screen/edit_screen/textfield/pickers.dart';
import 'package:attract_group_test/ui/screen/edit_screen/textfield/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  final Film film;

  const EditScreen({
    this.film,
  });

  @override
  State<StatefulWidget> createState() {
    return _EditScreenState();
  }
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController;
  TextEditingController dateController;
  TextEditingController descriptionController;

  // File photo;

  final nameFocusNode = FocusNode();
  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController = TextEditingController(text: widget.film?.name ?? '');
    dateController =
        TextEditingController(text: widget.film?.time?.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.film?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return EditScreenBloc(
          widget.film,
          MyApp.filmInteractor,
        );
      },
      child: BlocConsumer<EditScreenBloc, EditScreenState>(
        listener: (BuildContext context, state) {
          var bloc = context.bloc<EditScreenBloc>();

          // if (state is TypeNameState) {
          //   nameController.text = state.text;
          // }
          //
          // if (state is TypeDateState) {
          //   dateController.text = state.dateText;
          // }
          // if (state is TypeDescriptionState) {
          //   descriptionController.text = state.text;
          // }

          if (state is NavigateBackState) {
            Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, EditScreenState state) {
          return Scaffold(
            appBar: _buildAppbar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPhotoPicker(
                      context,
                      state,
                    ),
                    _buildTextFields(
                      context,
                      state,
                    ),
                    _buildConfirmButton(
                      context,
                      state,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildPhotoPicker(BuildContext context, EditScreenState state) {
    return PhotoPicker(
      filmImage: widget.film != null ? widget.film.image : null,
      onImagePick: (File file) {
        context.bloc<EditScreenBloc>().add(ImagePickEvent(file));
      },
    );
  }

  Widget _buildTextFields(BuildContext context, EditScreenState state) {
    final bloc = context.bloc<EditScreenBloc>();
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        AdaptiveTextField(
          controller: nameController,
          focusNode: nameFocusNode,
          label: "Film name",
          onChange: (text) {
            bloc.add(TypeNameEvent(text));
          },
          onSubmitted: (text) async {
            FocusScope.of(context).requestFocus(dateFocusNode);
            var selectedDateTime = Platform.isAndroid
                ? await showAndroidPickers(context)
                : await showIosPickeres(context);
            if (selectedDateTime != null) {
              bloc.add(PickDateEvent(selectedDateTime.toString()));
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
            bloc.add(PickDateEvent(dateController.text));
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
          onChange: (text) {
            bloc.add(TypeDescriptionEvent(text));
          },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context, EditScreenState state) {
    final bloc = context.bloc<EditScreenBloc>();
    return ConfirmButton(
      label: state.type == ScreenType.create ? "create" : "edit",
      onPressed: state is ValidForms
          ? () {
              if (state.type == ScreenType.create) {
                bloc.add(AddNewFilmEvent());
                return;
              }
              return bloc.add(ChangeExistFilmEvent(
                image: state.image ?? File(widget.film.image) ,
                name: nameController.text,
                date: dateController.text,
                description: descriptionController.text,
              ));
            }
          : null,
    );
  }
}

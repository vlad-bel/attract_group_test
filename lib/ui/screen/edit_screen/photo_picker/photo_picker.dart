import 'dart:io';

import 'package:attract_group_test/ui/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatefulWidget {
  final Function(File file) onImagePick;

  final String filmImage;

  PhotoPicker({
    @required this.onImagePick,
    this.filmImage,
  });

  @override
  State<StatefulWidget> createState() {
    return PhotoPickerState();
  }
}

class PhotoPickerState extends State<PhotoPicker> {
  File imageFile;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: InkWell(
        onTap: () async {
          _showImagePickDialog();
        },
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.blue,
            image: _buildPhoto(),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: _buildImagePick(),
        ),
      ),
    );
  }

  DecorationImage _buildPhoto() {
    if (widget.filmImage != null) {
      if (imageFile != null) {
        return DecorationImage(
          image: FileImage(imageFile),
          fit: BoxFit.fitWidth,
        );
      }
      return DecorationImage(
        image: _buildInitialPhoto(),
        fit: BoxFit.fitWidth,
      );
    }
    if (imageFile != null) {
      return DecorationImage(
        image: FileImage(imageFile),
        fit: BoxFit.fitWidth,
      );
    }

    return null;
  }

  ImageProvider _buildInitialPhoto() {
    bool validURL = Uri.parse(widget.filmImage).isAbsolute;
    if (validURL) {
      return NetworkImage(widget.filmImage);
    }

    return FileImage(File(widget.filmImage));
  }

  Widget _buildImagePick() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          imageFile != null ? Icons.edit_outlined : Icons.photo_outlined,
          size: imageFile != null ? 32 : 64,
          color: Colors.white,
        ),

        ///TODO настроить стиль
        Text(
          photoPickerTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  void _showImagePickDialog() async {
    Widget cameraButton = Platform.isAndroid
        ? FlatButton(
            child: Text(cameraPickTitle),
            onPressed: () => getImage(ImageSource.camera),
          )
        : CupertinoButton(
            child: Text(cameraPickTitle),
            onPressed: () => getImage(ImageSource.camera),
          );

    Widget galleryButton = Platform.isAndroid
        ? FlatButton(
            child: Text(galleryPickTitle),
            onPressed: () => getImage(ImageSource.gallery),
          )
        : CupertinoButton(
            child: Text(galleryPickTitle),
            onPressed: () => getImage(ImageSource.gallery),
          );

    // set up the AlertDialog
    await showDialog(
      context: context,
      child: Platform.isAndroid
          ? AlertDialog(
              title: Text(alertDialogTitle),
              content: Text(alertDialogContent),
              actions: [
                cameraButton,
                galleryButton,
              ],
            )
          : CupertinoAlertDialog(
              title: Text(alertDialogTitle),
              content: Text(alertDialogContent),
              actions: [
                cameraButton,
                galleryButton,
              ],
            ),
    );
  }

  void getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });

    widget.onImagePick(imageFile);
    Navigator.of(context).pop();
  }
}

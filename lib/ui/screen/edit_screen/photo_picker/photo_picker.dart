import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatefulWidget {
  final Function(File file) onImagePick;

  PhotoPicker({@required this.onImagePick});

  @override
  State<StatefulWidget> createState() {
    return PhotoPickerState();
  }
}

class PhotoPickerState extends State<PhotoPicker> {
  File imageFile;

  final picker = ImagePicker();

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
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.fitWidth,
                  )
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: _buildImagePick(),
        ),
      ),
    );
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
          imageFile != null ? "change image" : 'add image',
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
            child: Text("Camera"),
            onPressed: () => getImage(ImageSource.camera),
          )
        : CupertinoButton(
            child: Text("Camera"),
            onPressed: () => getImage(ImageSource.camera),
          );

    Widget galleryButton = Platform.isAndroid
        ? FlatButton(
            child: Text("Gallery"),
            onPressed: () => getImage(ImageSource.gallery),
          )
        : CupertinoButton(
            child: Text("Gallery"),
            onPressed: () => getImage(ImageSource.gallery),
          );

    // set up the AlertDialog
    await showDialog(
      context: context,
      child: Platform.isAndroid
          ? AlertDialog(
              title: Text("Image picker"),
              content: Text(
                  "Selecting a photo from the camera or from the gallery?"),
              actions: [
                cameraButton,
                galleryButton,
              ],
            )
          : CupertinoAlertDialog(
              title: Text("Image picker"),
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
      } else {
        print('No image selected.');
      }
    });

    widget.onImagePick(imageFile);
    Navigator.of(context).pop();
  }
}

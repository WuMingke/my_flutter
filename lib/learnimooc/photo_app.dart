import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoApp extends StatefulWidget {
  const PhotoApp({Key? key}) : super(key: key);

  @override
  State<PhotoApp> createState() => _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {
  File? _image;

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      // _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              _pickImage();
            },
            child: const Text("弹窗"),
          ),
        ),
      ],
    );
  }

  _pickImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 160,
        child: Column(
          children: [
            _item("拍照", true),
            _item("从相册选择", false),
          ],
        ),
      ),
    );
  }

  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () {
          getImage(isTakePhoto);
        },
      ),
    );
  }
}

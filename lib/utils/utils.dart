import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: imageSource);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  // ignore: avoid_print
  print('No Image Selected');
}

showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

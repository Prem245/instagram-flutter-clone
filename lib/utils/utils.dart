import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter_clone/utils/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? file = await _imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }

  print("No image selected");
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: Text(
        message,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    ),
  );
}

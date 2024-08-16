import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> imageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}

Future<XFile?> get imageFromCamera async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickImage = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  return pickImage;
}

Future<XFile?> get pickVideo async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickImage = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  return pickImage;
}

class ImageProvider extends ChangeNotifier {
  var image = '';

  void setProfile(String file) {
    image = file;
    notifyListeners();
  }
}

class ImageProviders extends StateNotifier<File> {
  ImageProviders() : super(File(''));
  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = File(pickedFile.path);
    }
  }
}

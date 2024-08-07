import 'dart:io'; // Import for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider extends ChangeNotifier {
  bool isLoading = false;
  String error = "";
  File? _imageFile;

  File? get imageFile => _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> fromCamera() async {
    try {
      isLoading = true;
      notifyListeners();

      final pickedImage = await _picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        error = "";
      } else {
        _imageFile = null;
        error = "No image selected.";
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = "An error occurred: $e";
      notifyListeners();
    }
  }

  Future<void> fromGallery() async {
    try {
      isLoading = true;
      notifyListeners();

      // Pick an image from the gallery
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        _imageFile = File(pickedImage.path); // Convert XFile to File
        error = "";
      } else {
        _imageFile = null;
        error = "No image selected.";
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = "An error occurred: $e";
      notifyListeners();
    }
  }
}

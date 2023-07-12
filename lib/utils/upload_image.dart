import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageFileProvider = FutureProvider(
  (ref) => PickDeviceImage().pickImage(),
);

class PickDeviceImage {
  Future<XFile?> pickImage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) return image;
    return null;
  }
}

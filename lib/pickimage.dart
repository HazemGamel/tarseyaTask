
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ChooseImage{
  File? _image;
  var picker = ImagePicker();
 Future  getImage(bool isCamera) async
  {
    final pickedFile = await
    picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image!;
    }
  }
}
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:resto/utils/enums.dart';

Future<File?> pickImage() async {
  File? image;
  final picker = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowCompression: true,
  );

  if (picker != null && picker.files.isNotEmpty) {
    image = File(picker.files.first.path!);
  }

  return image;
}

class RoleConverter {
  static Role fromInt(int roleInt) {
    switch (roleInt) {
      case 0:
        return Role.admin;
      case 1:
        return Role.chef;
      case 2:
        return Role.gerant;
      case 3:
        return Role.client;
      default:
        throw ArgumentError('Invalid role integer: $roleInt');
    }
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruiteshubdashboard2/core/services/storage_service.dart';
import 'package:path/path.dart' as b;

class FireStorage implements StorageService {
  final storageRefrence = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadFile(File file, String path) async {
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);
    var fileRefrence = storageRefrence.child('$path/$fileName.$extensionName'); //المسار قبل ال file+الصورة نفسها
    await fileRefrence.putFile(file);
    var fileUrl = fileRefrence.getDownloadURL();
    return fileUrl;
  }
}

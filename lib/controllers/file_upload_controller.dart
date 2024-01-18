import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class FileUploadController {
  // upload pick image file to the firebase storage bucket in the given path
  Future<String> uploadFile(File file, String folderPath) async {
    try {
      //  getting the file name from the file path
      final String fileName = basename(file.path);

      // define the path where the file will be stored
      final String destination = "$folderPath/$fileName";

      // creating the firebase storage reference
      final ref = FirebaseStorage.instance.ref(destination);

      // uploading the file to the firebase storage
      final UploadTask task = ref.putFile(file);

      // await the task to complete
      final snapshot = await task.whenComplete(() {});

      // getting the download url of the uploaded file
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
  
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      final uploadFileData =
          await storage.ref('uploads/$fileName').putFile(file);
      final downloadURL = await uploadFileData.ref.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}

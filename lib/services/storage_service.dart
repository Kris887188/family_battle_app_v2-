import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Загружает файл по локальному пути [filePath] в папку tasks/[taskId] и возвращает URL
  Future<String> uploadTaskMedia(String taskId, String filePath) async {
    final file = File(filePath);
    final ref = _storage
        .ref()
        .child('tasks')
        .child(taskId)
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    final uploadTask = await ref.putFile(file);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import '../services/firestore_service.dart';
import '../models/task.dart';

class MediaPreviewScreen extends StatelessWidget {
  final Task task;
  final File file;
  const MediaPreviewScreen({Key? key, required this.task, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview: ${task.title}')),
      body: Column(
        children: [
          Expanded(child: Image.file(file)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () async {
                // upload
                final url = await context.read<StorageService>().uploadTaskMedia(task.id, file.path);
                await context.read<FirestoreService>().completeTask(task.id, url, task.xpReward);
                Navigator.of(context).popUntil((r) => r.isFirst);
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Загрузить результат'),
            ),
          ),
        ],
      ),
    );
  }
}
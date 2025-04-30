import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import 'media_preview_screen.dart';

class TaskScreen extends StatelessWidget {
  final Task task;
  const TaskScreen({Key? key, required this.task}) : super(key: key);

  Future<void> _pickAndPreview(BuildContext context) async {
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.camera);
    if (xfile == null) return;
    final file = File(xfile.path);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaPreviewScreen(task: task, file: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(task.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _pickAndPreview(context),
              child: const Text('Выполнить задание'),
            ),
          ],
        ),
      ),
    );
  }
}
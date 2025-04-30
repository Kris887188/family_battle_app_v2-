// lib/widgets/task_card.dart

import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetName;

    // Для первого задания — специальный бейдж
    if (task.id == 'Первое задание' || task.id == 'first') {
      assetName = 'first.png';
    }
    // Для всех фото-заданий
    else if (task.mediaType == 'photo') {
      assetName = 'photo.png';
    }
    // Для всех видео-заданий
    else if (task.mediaType == 'video') {
      assetName = 'video.png';
    }
    // На всякий случай — дефолт
    else {
      assetName = 'photo.png';
    }

    return ListTile(
      leading: Image.asset(
        'assets/icons/$assetName',
        width: 40,
        height: 40,
      ),
      title: Text(task.title),
      subtitle: Text('XP: ${task.xpReward} • Level: ${task.level}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.of(context).pushNamed(
        '/task',
        arguments: task,
      ),
    );
  }
}

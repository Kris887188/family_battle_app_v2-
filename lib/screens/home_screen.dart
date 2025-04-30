// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<FirestoreService>().tasks;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задания'),
        actions: [
          IconButton(
            key: const Key('achievements_btn'),
            icon: const Icon(Icons.emoji_events),
            onPressed: () => Navigator.of(context).pushNamed('/achievements'),
          ),
          IconButton(
            key: const Key('profile_btn'),
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, i) => TaskCard(task: tasks[i]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fs = context.watch<FirestoreService>();
    final AppUser? user = fs.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль семьи')),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Команда: ${user.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('XP: ${user.xp}  •  Level: ${user.level}'),
            const SizedBox(height: 16),
            const Text(
              'Выполненные задания:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: user.completedTasks
                    .map((taskId) => ListTile(
                  title: Text('Задание $taskId'),
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

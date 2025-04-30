// lib/screens/achievements_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Достижения')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('achievements')
            .orderBy(FieldPath.documentId)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.hasError) return Center(child: Text('Ошибка: ${snap.error}'));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('Нет доступных достижений'));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, i) {
              final data = docs[i].data()! as Map<String, dynamic>;
              return ListTile(
                leading: Image.network(
                  data['icon'] as String,
                  width: 40,
                  height: 40,
                  errorBuilder: (ctx, err, stack) {
                    // если URL неверный — показываем заглушку
                    return const Icon(Icons.shield, size: 40, color: Colors.grey);
                  },
                ),
                title: Text(data['name'] as String),
                subtitle: Text(data['description'] as String),
              );
            },
          );
        },
      ),
    );
  }
}

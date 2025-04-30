import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratings = context.watch<FirestoreService>().ratings;
    final sorted = ratings.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Scaffold(
      appBar: AppBar(title: const Text('Рейтинг')),
      body: ratings.isEmpty
          ? const Center(child: Text('Пока нет данных для рейтинга'))
          : ListView.builder(
        itemCount: sorted.length,
        itemBuilder: (ctx, i) {
          final e = sorted[i];
          return ListTile(
            leading: Text('#${i + 1}'),
            title: Text(e.key),
            trailing: Text('${e.value} XP'),
          );
        },
      ),
    );
  }
}
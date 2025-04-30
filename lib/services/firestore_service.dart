import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/task.dart';
import '../models/user.dart';

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Подписка на push-топик семьи
  Future<void> subscribeToFamilyTopic(String uid) async {
    await _messaging.subscribeToTopic('family_$uid');
  }

  /// Список всех заданий
  List<Task> tasks = [];

  /// Данные текущей семьи/пользователя
  AppUser? currentUser;

  /// Рейтинг за текущий месяц (userId → xp)
  Map<String, int> ratings = {};

  FirestoreService() {
    _loadTasks();
    _loadUser();
    _loadRatings();
  }

  /// Загрузка всех заданий из коллекции tasks
  Future<void> _loadTasks() async {
    final snap = await _db.collection('tasks').get();
    tasks = snap.docs.map((d) => Task.fromMap(d.id, d.data())).toList();
    notifyListeners();
  }

  /// Загрузка данных текущего пользователя
  Future<void> _loadUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      currentUser = AppUser.fromMap(doc.id, doc.data()!);
    } else {
      currentUser = AppUser(id: uid, name: 'Family');
      await _db.collection('users').doc(uid).set(currentUser!.toMap());
    }
    notifyListeners();
  }

  /// Отметить задание выполненным: загрузить mediaUrl, добавить XP, обновить документ
  Future<void> completeTask(String taskId, String mediaUrl, int xpReward) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // Сохраняем в подколлекцию completedTasks
    await _db
        .collection('users')
        .doc(uid)
        .collection('completedTasks')
        .doc(taskId)
        .set({
      'url': mediaUrl,
      'date': FieldValue.serverTimestamp(),
    });

    // Обновляем XP и уровень
    currentUser!.xp += xpReward;
    currentUser!.level = currentUser!.xp ~/ 500 + 1;
    await _db.collection('users').doc(uid).update({
      'xp': currentUser!.xp,
      'level': currentUser!.level,
    });

    // Обновляем рейтинг за месяц
    final now = DateTime.now();
    final monthCol = 'monthly_${now.year}_${now.month.toString().padLeft(2, '0')}';
    await _db
        .collection('ratings')
        .doc(monthCol)
        .collection('data')
        .doc(uid)
        .set({'xp': currentUser!.xp}, SetOptions(merge: true));

    // Перезагружаем локально данные
    await _loadUser();
    await _loadRatings();
    notifyListeners();
  }

  /// Загрузка рейтинга за текущий месяц
  Future<void> _loadRatings() async {
    final now = DateTime.now();
    final monthCol = 'monthly_${now.year}_${now.month.toString().padLeft(2, '0')}';
    final snap = await _db
        .collection('ratings')
        .doc(monthCol)
        .collection('data')
        .get();
    ratings = { for (var d in snap.docs) d.id: (d.data()['xp'] as int?) ?? 0 };
    notifyListeners();
  }
}

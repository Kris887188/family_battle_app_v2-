import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  String? avatarUrl;
  int xp;
  int level;
  String subscription;
  List<String> completedTasks;
  DateTime? createdAt;

  AppUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.xp = 0,
    this.level = 1,
    this.subscription = 'standard',
    this.completedTasks = const [],
    this.createdAt,
  });

  /// Создание из документа Firestore
  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? 'Family',
      avatarUrl: data['avatarUrl'],
      xp: data['xp'] ?? 0,
      level: data['level'] ?? 1,
      subscription: data['subscription'] ?? 'standard',
      completedTasks: List<String>.from(data['completedTasks'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Преобразование в карту для записи в Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatarUrl': avatarUrl,
      'xp': xp,
      'level': level,
      'subscription': subscription,
      'completedTasks': completedTasks,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }
}

// lib/models/task.dart

class Task {
  final String id;
  final String title;
  final String description;
  final String type;      // уровень сложности: "easy", "medium", "hard"
  final String mediaType; // тип медиа, по которому мы показываем разные иконки: "photo" или "video"
  final int level;
  final int xpReward;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.mediaType,
    required this.level,
    required this.xpReward,
  });

  factory Task.fromMap(String id, Map<String, dynamic> data) {
    return Task(
      id: id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      type: data['type'] as String? ?? 'easy',
      mediaType: data['mediaType'] as String? ?? 'photo',
      level: data['level'] as int? ?? 1,
      xpReward: data['xpReward'] as int? ?? 0,
    );
  }
}

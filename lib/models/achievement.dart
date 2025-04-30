class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;

  Achievement({required this.id, required this.name, required this.description, required this.icon});

  factory Achievement.fromMap(String id, Map<String, dynamic> data) {
    return Achievement(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      icon: data['icon'] ?? '',
    );
  }
}

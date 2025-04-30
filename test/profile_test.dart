import 'package:flutter_test/flutter_test.dart';
import 'package:family_battle_app/models/user.dart';

void main() {
  test('User level calculation', () {
    final user = AppUser(id: '1', name: 'Test', xp: 1200);
    expect(user.level, 1); // initial
  });
}

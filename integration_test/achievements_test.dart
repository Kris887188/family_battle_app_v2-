// integration_test/achievements_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:family_battle_app/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Achievements screen shows badges', (tester) async {
    // Запускаем приложение
    await app.main();
    await tester.pumpAndSettle();

    // Авторизуемся (если требуется)
    final emailField = find.byType(TextField);
    await tester.enterText(emailField, 'test@example.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Переходим в экран достижений через меню
    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle();

    // Ожидаем, что хотя бы один бейдж отобразится
    expect(find.byType(ListTile), findsWidgets);

    // Проверяем наличие иконки
    final firstBadge = find.byType(Image).first;
    expect(firstBadge, findsOneWidget);
  });
}

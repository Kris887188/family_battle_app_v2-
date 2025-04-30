// integration_test/profile_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:family_battle_app/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Profile screen shows XP and level', (tester) async {
    // Запускаем приложение
    await app.main();
    await tester.pumpAndSettle();

    // Авторизация
    await tester.enterText(find.byType(TextField), 'test@example.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Открываем профиль через иконку аккаунта
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pumpAndSettle();

    // Проверяем отображение XP и уровня
    expect(find.textContaining('XP:'), findsOneWidget);
    expect(find.textContaining('Level:'), findsOneWidget);
  });
}

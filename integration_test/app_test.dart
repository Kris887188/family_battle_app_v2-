// integration_test/app_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:family_battle_app/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete flow: auth → tasks list → open task', (tester) async {
    // Запускаем приложение
    app.main();
    await tester.pumpAndSettle();

    // Авторизация
    final emailField = find.byKey(const Key('email-field'));
    expect(emailField, findsOneWidget, reason: 'Поле ввода email должно быть на экране');
    await tester.enterText(emailField, 'test@example.com');
    await tester.pumpAndSettle();

    final sendButton = find.widgetWithText(ElevatedButton, 'Отправить код');
    expect(sendButton, findsOneWidget, reason: 'Кнопка отправки кода должна присутствовать');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    // Список заданий
    expect(find.byType(ListView), findsOneWidget, reason: 'После авторизации должен отобразиться список заданий');
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // TaskScreen
    expect(find.widgetWithText(ElevatedButton, 'Выполнить задание'), findsOneWidget,
        reason: 'На экране задания должна быть кнопка "Выполнить задание"');
  });

  testWidgets('Verify achievements screen', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Быстрая авторизация
    final emailField = find.byKey(const Key('email-field'));
    await tester.enterText(emailField, 'test@example.com');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Отправить код'));
    await tester.pumpAndSettle();

    // Переход к достижениям
    final achBtn = find.byKey(const Key('achievements_btn'));
    expect(achBtn, findsOneWidget, reason: 'Кнопка перехода в достижения должна быть в AppBar');
    await tester.tap(achBtn);
    await tester.pumpAndSettle();

    // Достижения или сообщение об отсутствии
    final tiles = find.byType(ListTile);
    final noData = find.text('Нет доступных достижений');
    expect(tiles.evaluate().isNotEmpty
        ? tiles
        : noData, findsOneWidget,
        reason: 'Должен быть список достижений или текст о том, что их нет');
  });

  testWidgets('Verify profile screen shows XP and level', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Авторизация
    final emailField = find.byKey(const Key('email-field'));
    await tester.enterText(emailField, 'test@example.com');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Отправить код'));
    await tester.pumpAndSettle();

    // Переход в профиль
    final profBtn = find.byKey(const Key('profile_btn'));
    expect(profBtn, findsOneWidget, reason: 'Кнопка перехода в профиль должна быть в AppBar');
    await tester.tap(profBtn);
    await tester.pumpAndSettle();

    // Проверяем, что отображаются XP и уровень
    expect(find.textContaining('XP'), findsOneWidget, reason: 'Должен отображаться текущий XP');
    expect(find.textContaining('Level'), findsOneWidget, reason: 'Должен отображаться текущий уровень');
  });
}

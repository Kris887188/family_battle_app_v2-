// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Импортируйте ваш main.dart, где объявлен FamilyBattleApp
import 'package:family_battle_app/main.dart';

void main() {
  testWidgets('App starts and shows AuthScreen', (WidgetTester tester) async {
    // Запускаем именно ваш корневой виджет
    await tester.pumpWidget(const FamilyBattleApp());
    await tester.pumpAndSettle();

    // Теперь проверяем, что на экране есть надпись из AuthScreen
    expect(find.text('Вход/Регистрация'), findsOneWidget);
  });
}

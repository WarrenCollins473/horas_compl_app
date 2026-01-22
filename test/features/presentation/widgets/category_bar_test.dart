import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/features/presentation/widgets/category_bar.dart';

void main() {
  testWidgets('CategoryBar shoud show title, values and progress corretly', (
    WidgetTester tester,
  ) async {
    // Arrange
    const title = 'Documentos';
    const current = 5;
    const total = 10;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const Scaffold(
          body: CategoryBar(title: title, current: current, total: total),
        ),
      ),
    );

    // Act - aguarda animação do TweenAnimationBuilder
    await tester.pump(); // inicia animação
    await tester.pump(const Duration(seconds: 1)); // termina animação

    // Assert - título
    expect(find.text(title), findsOneWidget);

    // Assert - texto current/total
    expect(find.text('$current/$total'), findsOneWidget);

    // Assert - LinearProgressIndicator existe
    final progressIndicatorFinder = find.byType(LinearProgressIndicator);
    expect(progressIndicatorFinder, findsOneWidget);

    // Assert - valor do progresso
    final progressIndicator = tester.widget<LinearProgressIndicator>(
      progressIndicatorFinder,
    );

    expect(progressIndicator.value, equals(current / total));
  });
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:horas_compl_app/features/data/datasources/curriculum_local_datasouce_implamentation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CurriculumLocalDatasourceImpl datasource;

  setUp(() {
    datasource = CurriculumLocalDatasourceImpl();
  });

  test('Should return a Map when JSON is loaded successfully', () async {
    // JSON fake
    final mockJson = json.encode({
      "categories": [
        {"name": "Test Category", "hours": 10},
      ],
    });

    // Mock do rootBundle

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          return Future.value(
            const StandardMethodCodec().encodeSuccessEnvelope(mockJson),
          );
        });

    final result = await datasource.loadCurriculum();

    expect(result, isA<Map<String, dynamic>>());
    expect(result['categories'], isNotNull);
  });

  test('Should throw FormatException when JSON is invalid', () async {
    const invalidJson = "invalid json";

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          return Future.value(
            const StandardMethodCodec().encodeSuccessEnvelope(invalidJson),
          );
        });

    expect(() => datasource.loadCurriculum(), throwsA(isA<FormatException>()));
  });
}

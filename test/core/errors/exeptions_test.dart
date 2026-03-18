import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/exeptions.dart';

void main() {
  test('Should be an instance of Exception', () {
    final exception = ServerExeption();

    expect(exception, isA<Exception>());
  });

  test('Should be equal to another instance (Equatable)', () {
    final exception1 = ServerExeption();
    final exception2 = ServerExeption();

    expect(exception1, equals(exception2));
  });

  test('Should have empty props list', () {
    final exception = ServerExeption();

    expect(exception.props, isEmpty);
  });
}

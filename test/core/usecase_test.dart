import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/core/usecase.dart';

// ========================
// FAKE IMPLEMENTATION
// ========================
class TestUsecase extends Usecase<String, int> {
  @override
  Future<Either<Failure, String>> call(int params) async {
    if (params > 0) {
      return Right('success');
    } else {
      return Left(ServerFailure());
    }
  }
}

void main() {
  // ========================
  // NoParams
  // ========================
  test('NoParams should be equal to another instance (Equatable)', () {
    final a = NoParams();
    final b = NoParams();

    expect(a, equals(b));
  });

  test('NoParams props should be empty', () {
    final noParams = NoParams();

    expect(noParams.props, isEmpty);
  });

  // ========================
  // Usecase
  // ========================
  test('Usecase should return Right when successful', () async {
    final usecase = TestUsecase();

    final result = await usecase(1);

    expect(result, equals(Right('success')));
  });

  test('Usecase should return Left when failure occurs', () async {
    final usecase = TestUsecase();

    final result = await usecase(0);

    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<ServerFailure>()),
      (r) => fail('Expected failure'),
    );
  });
}

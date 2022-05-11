import 'package:bazzwoo_test/core/domain/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_data/mock_countries_model.dart';
import '../mock/mocks/mock_repositories.dart';

void main() {
  late MockDetailsRepository mockRepository;

  setUp(() {
    mockRepository = MockDetailsRepository();
  });

  group('CountriesRepository', () {
    test('Add country to storage  with positive result', () async {
      when(
        () => mockRepository.addToFavorite(MockCountriesModel.country),
      ).thenAnswer(
        (invocation) async => right(unit),
      );
      expect(
        await mockRepository.addToFavorite(MockCountriesModel.country),
        right(unit),
      );
    });
    test('Get countries countries  with positive negative ', () async {
      when(
        () => mockRepository.addToFavorite(MockCountriesModel.country),
      ).thenAnswer(
        (invocation) async => left(const Failure.api()),
      );
      expect(
        await mockRepository.addToFavorite(MockCountriesModel.country),
        left(const Failure.api()),
      );
    });
  });
}

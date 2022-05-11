import 'package:bazzwoo_test/home/countries/domain/i_country_repository.dart';
import 'package:bazzwoo_test/home/details/domain/i_details_repository.dart';
import 'package:bazzwoo_test/home/favorites/domain/i_favorites_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCountriesRepository extends Mock implements ICountryRepository {}

class MockDetailsRepository extends Mock implements IDetailsRepository {}

class MockFavoritesRepository extends Mock implements IFavoritesRepository {}

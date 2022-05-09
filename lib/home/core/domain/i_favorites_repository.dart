import 'country.dart';

abstract class IFavoritesRepository {
  Stream<List<Country>> watchFavoriteCountry();
  Future<List<Country>> getFavoritesCountries();
}

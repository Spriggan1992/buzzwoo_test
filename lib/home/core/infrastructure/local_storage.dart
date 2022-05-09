import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../domain/country.dart';
import '../domain/i_local_storage.dart';
import 'dtos/country_dto.dart';

const _favorites = 'favorites';

@LazySingleton(as: ILocalStorage)
class LocalStorage implements ILocalStorage {
  final SembastDatabase _sembastDatabase;

  ///Store factory with key as int and value as Map
  final _store = StoreRef.main();

  LocalStorage(this._sembastDatabase);
  @override
  Future<void> save(
    Country country,
  ) async {
    await _store.record(country.id).put(
          _sembastDatabase.instance,
          CountryDTO.fromDomain(country).toJson(),
        );
  }

  @override
  Future<List<Country>> readAll() async {
    final response = await _store.find(_sembastDatabase.instance);

    return response.isEmpty
        ? []
        : response.map((e) => CountryDTO.fromJson(e.value).toDomain()).toList();
  }

  @override
  Future<void> delete(Country country) async {
    await _store.record(country.id).delete(_sembastDatabase.instance);
  }
}

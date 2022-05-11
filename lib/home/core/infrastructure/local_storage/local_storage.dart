import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../../domain/country.dart';
import '../../domain/exceptions/local_storage_exception.dart';
import 'i_local_storage.dart';
import '../dtos/country_dto.dart';

/// The callback request
typedef CallBackRequest<T> = Future<T> Function();

@LazySingleton(as: ILocalStorage)
class LocalStorage implements ILocalStorage {
  final SembastDatabase _sembastDatabase;

  ///Store factory with key as int and value as Map
  final _store = StoreRef.main();

  final StreamController<Country> _controller = StreamController.broadcast();

  /// Subscription for listening signals.
  @override
  Stream<Country> get subscription => _controller.stream;

  LocalStorage(this._sembastDatabase);
  @override
  Future<void> save(
    Country country,
  ) async {
    _makeRequest(() async => await _store.record(country.id).put(
          _sembastDatabase.instance,
          CountryDTO.fromDomain(country).toJson(),
        ));
  }

  @override
  Future<List<Country>> readAll() async {
    return _makeRequest(() async {
      final response = await _store.find(_sembastDatabase.instance);

      return response.isEmpty
          ? []
          : response
              .map((e) => CountryDTO.fromJson(e.value).toDomain())
              .toList();
    });
  }

  @override
  Future<void> delete(Country country) async {
    _makeRequest(
      () async {
        await _store.record(country.id).delete(_sembastDatabase.instance);

        _controller.sink.add(country);
      },
    );
  }

  @override
  Future<void> dispose() async {
    _controller.close();
  }
}

Future<T> _makeRequest<T>(
  CallBackRequest<T> callback,
) async {
  // try {
  final result = await callback();

  return result;
  // } catch (e) {
  //   log(e.toString());

  //   throw LocalStorageException();
  // }
}

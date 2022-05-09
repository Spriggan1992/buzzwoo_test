import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Defines class of initialization sembast database.
@lazySingleton
class SembastDatabase {
  late Database _instance;

  /// Get database instance.
  Database get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;
    final dbDirectory = await getApplicationDocumentsDirectory();
    dbDirectory.create(recursive: true);
    final dbPath = join(dbDirectory.path, 'db.sembast');
    _instance = await databaseFactoryIo.openDatabase(dbPath);
  }
}

/// Represent the app environments.
enum Environments { dev, prod }

/// Extension for environments.
extension EnvironmentsX on Environments {
  /// The development environments.
  static const String envNameDev = 'dev';

  /// The production environment.
  static const String envNameProd = 'prod';

  /// Get the environment name.
  String get name {
    if (this == Environments.prod) {
      return envNameProd;
    }

    return envNameDev;
  }

  /// Get the environment name from string.
  static Environments getEnvironmentFromString(String name) {
    if (name == envNameProd) {
      return Environments.prod;
    }

    return Environments.dev;
  }
}

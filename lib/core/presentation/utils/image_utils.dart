import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

Future<void> preloadImages(
  List<ImageProvider> imageProviders,
  double devicePixelRatio,
) async {
  for (var imageProvider in imageProviders) {
    await _preloadImage(imageProvider, devicePixelRatio);
  }
}

Future<void> _preloadImage(ImageProvider provider, double devicePixelRatio) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: devicePixelRatio,
    platform: defaultTargetPlatform,
  );
  final completer = Completer();
  final stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo image, bool sync) {
      completer.complete();
      stream.removeListener(listener);
    },
    onError: (dynamic exception, StackTrace? stackTrace) {
      completer.complete();
      stream.removeListener(listener);
      FlutterError.reportError(
        FlutterErrorDetails(
          context: ErrorDescription('image failed to load'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ),
      );
    },
  );

  stream.addListener(listener);

  return completer.future;
}

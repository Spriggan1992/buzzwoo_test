import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/app_icons.dart';
import '../../../../core/presentation/themes/app_colors.dart';

const _borderRadius = BorderRadius.all(
  Radius.circular(4),
);

/// Represent the widget to display country flag with loaded from internet.
class NetworkFlagImage extends StatelessWidget {
  /// The url of loading flag.
  final String imageUrl;

  final double? width;
  final double? height;

  const NetworkFlagImage(
    this.imageUrl, {
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const LoadingFlagContainer(),
      errorWidget: (context, url, error) => _FlagContainer(
        height: height,
        width: width,
      ),
      // imageBuilder: (context, imageProvider) => LoadingFlagContainer()
      imageBuilder: (context, imageProvider) => _FlagContainer(
        imageProvider: imageProvider,
        height: height,
        width: width,
      ),
    );
  }
}

class LoadingFlagContainer extends StatelessWidget {
  const LoadingFlagContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray3,
      highlightColor: AppColors.gray5,
      child: _FlagContainer(),
    );
  }
}

class _FlagContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final ImageProvider<Object>? imageProvider;
  const _FlagContainer({
    Key? key,
    this.imageProvider,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: _borderRadius,
      child: Container(
        margin: const EdgeInsets.all(6),
        width: width ?? 90,
        height: height,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: AppColors.gray2,
          image: DecorationImage(
            image: imageProvider != null
                ? imageProvider!
                : Image.asset(
                    AppIcons.pirate_flag,
                  ).image,
            fit: BoxFit.cover,
          ),
          // image: imageProvider != null
          //     ? DecorationImage(
          //         image: imageProvider!,
          //         fit: BoxFit.cover,
          //       )
          //     : null,
        ),
      ),
    );
  }
}

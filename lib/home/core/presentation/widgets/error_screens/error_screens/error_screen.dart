import 'package:flutter/material.dart';

import '../../../../../../../core/presentation/themes/app_colors.dart';
import '../../../../../../core/domain/failure.dart';
import '../base_error_screen.dart';

const _error = 'Try again';

/// Defines screen, that usually showing error.
class ErrorScreen extends BaseErrorScreen {
  final Failure failure;

  /// Error title to display.
  final String errorTitle;

  /// Call when user tap on 'Again' button.
  final VoidCallback? onTryAgain;
  ErrorScreen({
    required this.failure,
    required this.onTryAgain,
    this.errorTitle = _error,
    Key? key,
  }) : super(
          key,
          _getErrorMessage(failure),
          GestureDetector(
            onTap: onTryAgain,
            child: const Text(
              _error,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
}

String _getErrorMessage(Failure failure) {
  return failure.when(
    api: (_) => 'Something went wrong...',
    noConnection: () => 'Connection error.\nCheck your internet connection.',
  );
}

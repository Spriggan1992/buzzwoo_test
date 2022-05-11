import 'package:flutter/material.dart';

/// Base widget for screens error.
class BaseErrorScreen extends StatelessWidget {
  /// Error title to display.
  final String baseTitle;

  /// Error screen action.
  final Widget action;

  const BaseErrorScreen(
    Key? key,
    this.baseTitle,
    this.action,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                baseTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              action,
            ],
          ),
        ),
      ),
    );
  }
}

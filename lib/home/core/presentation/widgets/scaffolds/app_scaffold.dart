import 'package:flutter/material.dart';

/// Represent main app scaffold.
class AppScaffold extends StatelessWidget {
  /// Creates a widget that insets its child.
  final Widget body;

  const AppScaffold({
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 54,
            left: 24,
            right: 24,
          ),
          child: body,
        ),
      ),
    );
  }
}

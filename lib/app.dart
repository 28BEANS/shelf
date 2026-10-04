import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'screens/entry_screen.dart';
import 'services/shelf_auth.dart';
import 'theme.dart';

class ShelfApp extends StatelessWidget {
  const ShelfApp({
    super.key,
    this.authGateway,
    this.enableDemoReset = const bool.fromEnvironment(
      'SHELF_ENABLE_DEMO_RESET',
    ),
  });

  final ShelfAuthGateway? authGateway;
  final bool enableDemoReset;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: shelfTheme,
      home: EntryScreen(
        authGateway: authGateway,
        enableDemoReset: enableDemoReset,
      ),
    );
  }
}

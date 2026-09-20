import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'screens/entry_screen.dart';
import 'theme.dart';

class ShelfApp extends StatelessWidget {
  const ShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: shelfTheme,
      home: const EntryScreen(),
    );
  }
}

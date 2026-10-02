import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'services/shelf_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const url = String.fromEnvironment('SUPABASE_URL');
  const publicKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  if (url.isNotEmpty && publicKey.isNotEmpty) {
    await Supabase.initialize(
      url: url,
      publishableKey: publicKey,
      authOptions: const FlutterAuthClientOptions(
        localStorage: ShelfSessionStorage(),
      ),
    );
  }
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode && kIsWeb,
        builder: (_) => const ShelfApp(),
      ),
    ),
  );
}

class MyApp extends ShelfApp {
  const MyApp({super.key});
}

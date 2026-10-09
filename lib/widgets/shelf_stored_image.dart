import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> shelfMediaFile(String? relativePath) async {
  if (kIsWeb || relativePath == null || relativePath.isEmpty) return null;
  if (!relativePath.startsWith('ShelfMedia/') || relativePath.contains('..')) {
    return null;
  }
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$relativePath');
  return await file.exists() ? file : null;
}

Future<void> discardShelfMedia(String? relativePath) async {
  final file = await shelfMediaFile(relativePath);
  if (file != null) await file.delete();
}

Future<void> clearShelfMedia() async {
  if (kIsWeb) return;
  final documents = await getApplicationDocumentsDirectory();
  final media = Directory('${documents.path}/ShelfMedia');
  if (await media.exists()) await media.delete(recursive: true);
}

class ShelfStoredImage extends StatelessWidget {
  const ShelfStoredImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.placeholder,
  });
  final String? path;
  final BoxFit fit;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) => FutureBuilder<File?>(
    future: shelfMediaFile(path),
    builder: (context, snapshot) {
      final file = snapshot.data;
      if (file == null) {
        return placeholder ??
            const Center(child: Icon(Icons.image_not_supported_outlined));
      }
      return Image.file(
        file,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, _, _) =>
            placeholder ??
            const Center(child: Icon(Icons.broken_image_outlined)),
      );
    },
  );
}

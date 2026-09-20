import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:final_project/data/app_database.dart';

void main() {
  test('Drift item survives reopen and accepts a status update', () async {
    final directory = await Directory.systemTemp.createTemp('shelf-drift-test');
    final file = File('${directory.path}/shelf.sqlite');

    var database = AppDatabase(NativeDatabase(file));
    await database.saveSpikeItem(id: 'camera-1', name: 'Mirrorless Camera');
    await database.close();

    database = AppDatabase(NativeDatabase(file));
    expect(
      (await database.readSpikeItem('camera-1'))?.name,
      'Mirrorless Camera',
    );
    await database.updateSpikeStatus('camera-1', 'checkedOut');
    expect((await database.readSpikeItem('camera-1'))?.status, 'checkedOut');
    await database.close();

    await directory.delete(recursive: true);
  });
}

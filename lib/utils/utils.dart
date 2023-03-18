// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:uuid/uuid.dart';

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

void saveToDownloads({
  required String csv,
  required String filename,
}) async {
  try {
    const uuid = Uuid();
    final documentDirectory = await getApplicationDocumentsDirectory();

    final csvFile =
        await File('${documentDirectory.path}/$filename-${uuid.v4()}.csv')
            .writeAsString(csv);

    ShareExtend.share(csvFile.path, 'file');
  } catch (e) {
    log('Failed sharing CSV, reason:\n$e', level: 1000);
  }
}

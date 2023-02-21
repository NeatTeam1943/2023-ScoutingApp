// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

void saveToDownloads({
  required String filename,
  required String content,
}) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file =
        await File('${directory.path}/$filename').writeAsString(content);

    ShareExtend.share(file.path, 'file');
  } catch (e) {
    log('Failed sharing CSV, reason:\n$e', level: 1000);
  }
}

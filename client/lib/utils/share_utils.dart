import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Captures a PNG image of the widget tree.
Future<Uint8List> capturePng(GlobalKey key) async {
  final boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 3.0);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

/// Saves an image to the device.
Future<File> saveImage(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/share_image.png';
  final imageFile = File(imagePath);
  return await imageFile.writeAsBytes(bytes);
}

/// Converts a file to an X file.
XFile getXFile(File imageFile) {
  // Convert the file to an X file
  final xFile = XFile(
    imageFile.path,
    name: 'share_image.png',
    mimeType: 'image/png',
  );
  return xFile;
}

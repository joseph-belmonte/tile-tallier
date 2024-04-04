import 'package:logger/logger.dart';

/// The logger instance for the application.
// A configuration is held in this file.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

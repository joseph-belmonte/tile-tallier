import 'package:logger/logger.dart';

/// The logger instance for the application.
// A configuration is held in this file.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 3,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

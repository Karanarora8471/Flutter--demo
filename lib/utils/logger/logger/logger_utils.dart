
import 'package:logger/logger.dart';

class LoggerX {
  static final Logger log = Logger();

  static void write(String text, {bool isError = false}) {
    Future.microtask(() => isError ? log.e(text) : log.i(text));
  }
}

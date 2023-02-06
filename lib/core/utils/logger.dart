import 'package:logger/logger.dart' as logger_package;

abstract class Logger {
  void verbose(Object message);
  void information(Object message);
  void debug(Object message);
  void warning(Object message);
  void error(Object message);
  void wtf(Object message);
}

class LoggerImpl extends Logger {
  final _logger = logger_package.Logger(
    printer: logger_package.PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      printTime: true,
    ),
  );

  @override
  void debug(Object message) {
    _logger.d(message);
  }

  @override
  void error(Object message) {
    _logger.e(message);
  }

  @override
  void information(Object message) {
    _logger.i(message);
  }

  @override
  void verbose(Object message) {
    _logger.v(message);
  }

  @override
  void warning(Object message) {
    _logger.w(message);
  }

  @override
  void wtf(Object message) {
    _logger.wtf(message);
  }
}

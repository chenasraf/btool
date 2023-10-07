import 'package:colorize/colorize.dart';

import 'color.dart';

enum LogLevel {
  none,
  info,
  warn,
  error,
  debug,
}

const logLevelNum = <LogLevel, int>{
  LogLevel.none: 0,
  LogLevel.info: 1,
  LogLevel.warn: 2,
  LogLevel.error: 3,
  LogLevel.debug: 4,
};

class Logger {
  LogLevel level = LogLevel.error;

  // ignore: avoid_print
  void write(Object message) => print(message.toString());
  void writeLevel(LogLevel level, Object message, {required Styles fg}) {
    // ignore: avoid_print
    if (logLevelNum[level]! > logLevelNum[this.level]!) {
      return;
    }
    if (fg == Styles.DEFAULT) {
      write(message);
      return;
    }
    write(colorize(message.toString(), fg: fg));
  }

  void info(Object message) =>
      writeLevel(LogLevel.info, message, fg: Styles.DEFAULT);
  void i(Object message) => info(message);

  void warn(Object message) =>
      writeLevel(LogLevel.warn, message, fg: Styles.YELLOW);
  void w(Object message) => warn(message);

  void error(Object message) =>
      writeLevel(LogLevel.error, message, fg: Styles.RED);
  void e(Object message) => error(message);

  void debug(Object message) =>
      writeLevel(LogLevel.debug, message, fg: Styles.LIGHT_BLUE);
  void d(Object message) => debug(message);
}

final logger = Logger();

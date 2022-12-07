import 'package:colorize/colorize.dart';

String colorize(String message, {required Styles fg}) {
  return Colorize(message).apply(fg).toString();
}

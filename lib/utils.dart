import 'package:file/file.dart';


class _BToolBaseException implements Exception {
  final String message;
  _BToolBaseException(this.message);

  @override
  String toString() => message;
}

class BToolException extends _BToolBaseException {
  BToolException(super.message);
}

class BToolOptionsException extends _BToolBaseException {
  BToolOptionsException(super.message);
}

Directory getCurrentDir(Directory? workingDir, {required FileSystem fs}) {
  return workingDir ?? fs.currentDirectory;
}

library btools;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as path;

String getPubspecKey(String key, {FileSystem? fs}) {
  final _fs = fs ?? const LocalFileSystem();
  final pubspecFile = _fs.file(path.join(_fs.currentDirectory.path, 'pubspec.yaml'));
  final value = pubspecFile
      .readAsStringSync()
      .split('\n')
      .firstWhere((x) => x.startsWith('$key:'))
      .split(':')
      .last
      .trim();
  return value;
}

void setPubspecKey(String key, String value, {FileSystem? fs}) {
  final _fs = fs ?? const LocalFileSystem();
  final pubspecFile = _fs.file(path.join(_fs.currentDirectory.path, 'pubspec.yaml'));
  final lines = pubspecFile.readAsStringSync().split('\n');
  final index = lines.indexWhere((x) => x.startsWith('$key:'));
  lines[index] = '$key: $value';
  pubspecFile.writeAsStringSync(lines.join('\n'));
}

String getPackageName({FileSystem? fs}) => getPubspecKey('name', fs: fs);
void setPackageName(String value, {FileSystem? fs}) => setPubspecKey('name', value, fs: fs);
String getPackageVersion({FileSystem? fs}) => getPubspecKey('version', fs: fs);
void setPackageVersion(String value, {FileSystem? fs}) => setPubspecKey('version', value, fs: fs);

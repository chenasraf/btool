library btools;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as path;

import 'logger.dart';
import 'utils.dart';

String getPubspecKey(String key, {FileSystem? fs, Directory? workingDir}) {
  final _fs = fs ?? const LocalFileSystem();
  final wd = getCurrentDir(workingDir, fs: _fs).path;
  final pubspecFile = _fs.file(path.join(wd, 'pubspec.yaml'));
  logger.debug('Getting $key from ${pubspecFile.path}');
  final value = pubspecFile
      .readAsStringSync()
      .split('\n')
      .firstWhere((x) => x.startsWith('$key:'))
      .split(':')
      .last
      .trim();
  return value;
}

void setPubspecKey(String key, String value, {FileSystem? fs, Directory? workingDir}) {
  final _fs = fs ?? const LocalFileSystem();
  final wd = getCurrentDir(workingDir, fs: _fs).path;
  final pubspecFile = _fs.file(path.join(wd, 'pubspec.yaml'));
  final lines = pubspecFile.readAsStringSync().split('\n');
  final index = lines.indexWhere((x) => x.startsWith('$key:'));
  lines[index] = '$key: $value';
  logger.debug('Setting $key: $value from ${pubspecFile.path}');
  pubspecFile.writeAsStringSync(lines.join('\n'));
}

String getPackageName({FileSystem? fs, Directory? workingDir}) => getPubspecKey(
      'name',
      fs: fs,
      workingDir: workingDir,
    );
void setPackageName(String value, {FileSystem? fs, Directory? workingDir}) => setPubspecKey(
      'name',
      value,
      fs: fs,
      workingDir: workingDir,
    );

String getPackageVersion({FileSystem? fs, Directory? workingDir}) => getPubspecKey(
      'version',
      fs: fs,
      workingDir: workingDir,
    );
void setPackageVersion(String value, {FileSystem? fs, Directory? workingDir}) => setPubspecKey(
      'version',
      value,
      fs: fs,
      workingDir: workingDir,
    );

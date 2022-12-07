library btools;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as path;

String getBuildGradleKey(String key, {FileSystem? fs}) {
  final _fs = fs ?? const LocalFileSystem();
  final buildFile = _fs.file(
    path.join(_fs.currentDirectory.path, 'android', 'app', 'build.gradle'),
  );
  final value = buildFile
      .readAsStringSync()
      .split('\n')
      .firstWhere((x) => x.trim().startsWith(key))
      .trim()
      .split(' ')
      .last;
  return value;
}

void setBuildGradleKey(String key, String value, {FileSystem? fs}) {
  final _fs = fs ?? const LocalFileSystem();
  final buildFile = _fs.file(
    path.join(_fs.currentDirectory.path, 'android', 'app', 'build.gradle'),
  );
  final lines = buildFile.readAsStringSync().split('\n');
  final index = lines.indexWhere((x) => x.trim().startsWith(key));
  final line = lines[index];
  final oldValue = line.split(' ').last;
  lines[index] = lines[index].replaceAll(oldValue, value);
  buildFile.writeAsStringSync(lines.join('\n'));
}

String getMinSdkVersion({FileSystem? fs}) => getBuildGradleKey('minSdkVersion', fs: fs);
void setMinSdkVersion(String value, {FileSystem? fs}) =>
    setBuildGradleKey('minSdkVersion', value, fs: fs);
String getTargetSdkVersion({FileSystem? fs}) => getBuildGradleKey('targetSdkVersion', fs: fs);
void setTargetSdkVersion(String value, {FileSystem? fs}) =>
    setBuildGradleKey('targetSdkVersion', value, fs: fs);
String getApplicationId({FileSystem? fs}) =>
    getBuildGradleKey('applicationId', fs: fs).replaceAll('"', '');
void setApplicationId(String value, {FileSystem? fs}) =>
    setBuildGradleKey('applicationId', '"$value"', fs: fs);

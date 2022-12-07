library btool.build_gradle_utils;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as path;

import 'logger.dart';
import 'utils.dart';

String getBuildGradleKey(String key, {FileSystem? fs, Directory? workingDir}) {
  final _fs = fs ?? const LocalFileSystem();
  final wd = getCurrentDir(workingDir, fs: _fs).path;
  final buildFile = _fs.file(
    path.join(wd, 'android', 'app', 'build.gradle'),
  );
  logger.debug('Getting $key from ${buildFile.path}');

  final value = buildFile
      .readAsStringSync()
      .split('\n')
      .firstWhere((x) => x.trim().startsWith(key))
      .trim()
      .split(' ')
      .last;
  return value;
}

void setBuildGradleKey(String key, String value,
    {FileSystem? fs, Directory? workingDir}) {
  final _fs = fs ?? const LocalFileSystem();
  final wd = getCurrentDir(workingDir, fs: _fs).path;
  final buildFile = _fs.file(
    path.join(wd, 'android', 'app', 'build.gradle'),
  );
  final lines = buildFile.readAsStringSync().split('\n');
  final index = lines.indexWhere((x) => x.trim().startsWith(key));
  final line = lines[index];
  final oldValue = line.split(' ').last;
  lines[index] = lines[index].replaceAll(oldValue, value);
  logger.debug('Setting $key: $value from ${buildFile.path}');
  buildFile.writeAsStringSync(lines.join('\n'));
}

String getMinSdkVersion({FileSystem? fs, Directory? workingDir}) =>
    getBuildGradleKey(
      'minSdkVersion',
      fs: fs,
      workingDir: workingDir,
    );
void setMinSdkVersion(String value, {FileSystem? fs, Directory? workingDir}) =>
    setBuildGradleKey(
      'minSdkVersion',
      value,
      fs: fs,
      workingDir: workingDir,
    );

String getTargetSdkVersion({FileSystem? fs, Directory? workingDir}) =>
    getBuildGradleKey(
      'targetSdkVersion',
      fs: fs,
      workingDir: workingDir,
    );
void setTargetSdkVersion(String value,
        {FileSystem? fs, Directory? workingDir}) =>
    setBuildGradleKey(
      'targetSdkVersion',
      value,
      fs: fs,
      workingDir: workingDir,
    );

String getApplicationId({FileSystem? fs, Directory? workingDir}) =>
    getBuildGradleKey(
      'applicationId',
      fs: fs,
      workingDir: workingDir,
    ).replaceAll('"', '');
void setApplicationId(String value, {FileSystem? fs, Directory? workingDir}) =>
    setBuildGradleKey(
      'applicationId',
      '"$value"',
      fs: fs,
      workingDir: workingDir,
    );

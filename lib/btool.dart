library btool;

import 'dart:io';

import 'package:file/file.dart';
import 'package:file/local.dart';

import 'options.dart';
import 'build_gradle_utils.dart';
import 'pubspec_utils.dart';
import 'utils.dart';

class GetSetAction {
  final BToolAction action;
  final String? value;
  final String Function() getter;
  final void Function(String) setter;

  GetSetAction({
    required this.action,
    required this.value,
    required this.getter,
    required this.setter,
  });

  void run() {
    switch (action) {
      case BToolAction.get:
        print(getter());
        break;
      case BToolAction.set:
        if (value == null) {
          throw BToolException('Value not specified');
        }
        setter(value!);
        break;
    }
  }
}

void btoolRunner(
  Iterable<String> args, {
  FileSystem? fs,
  String? binVersion,
}) {
  try {
    final options = BToolOptions.fromArgs(args, binVersion: binVersion);
    final action = getAction(options, fs: fs ?? const LocalFileSystem());
    action.run();
    //
  } catch (e) {
    print(e);
    exit(1);
  }
  // '{{VERSION}}'
}

GetSetAction getAction(BToolOptions options, {required FileSystem fs}) {
  late String Function() getter;
  late void Function(String value) setter;
  switch (options.key) {
    case BToolOptionKey.minSdkVersion:
      getter = () => getMinSdkVersion(fs: fs);
      setter = (value) => setMinSdkVersion(value, fs: fs);
      break;
    case BToolOptionKey.targetSdkVersion:
      getter = () => getTargetSdkVersion(fs: fs);
      setter = (value) => setTargetSdkVersion(value, fs: fs);
      break;
    case BToolOptionKey.applicationId:
      getter = () => getApplicationId(fs: fs);
      setter = (value) => setApplicationId(value, fs: fs);
      break;
    case BToolOptionKey.packageName:
      getter = () => getPackageName(fs: fs);
      setter = (value) => setPackageName(value, fs: fs);
      break;
    case BToolOptionKey.packageVersion:
      getter = () => getPackageVersion(fs: fs);
      setter = (value) => setPackageVersion(value, fs: fs);
      break;
    default:
      throw BToolException('Unknown key: ${options.key}');
  }

  return GetSetAction(
    action: options.action,
    value: options.value,
    getter: getter,
    setter: setter,
  );
}

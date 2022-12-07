import 'dart:io';

import 'package:args/args.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as path;

import 'pubspec_utils.dart';
import 'utils.dart';

enum BToolAction {
  get,
  set,
}

enum BToolOptionKey {
  minSdkVersion,
  targetSdkVersion,
  packageVersion,
  packageName,
  applicationId,
}

class BToolOptions {
  final BToolAction action;
  final BToolOptionKey key;
  final Iterable<String> args;
  final String? value;

  BToolOptions({
    required this.key,
    required this.action,
    this.args = const [],
    this.value,
  });

  factory BToolOptions.fromArgs(Iterable<String> args, {String? binVersion}) {
    BToolOptionKey _key;
    BToolAction _action;
    Iterable<String>? _args;
    String? _value;
    final parser = ArgParser(allowTrailingOptions: true);
    parser.addFlag('help', abbr: 'h', negatable: false, help: 'Show help');
    parser.addFlag('version', abbr: 'v', negatable: false, help: 'Show version');
    parser.addFlag('verbose', abbr: 'V', negatable: false, help: 'Verbose output');
    final res = parser.parse(args);
    if (res['help'] == true) {
      print(parser.usage);
      exit(0);
    }
    if (res['version'] == true) {
      print('btool version ${binVersion ?? 'local'}');
      exit(0);
    }
    if (res.rest.length > 1) {
      try {
        _action = BToolAction.values.firstWhere((e) => e.name == res.rest[0]);
      } catch (e) {
        throw BToolException('Unknown action: ${res.rest[0]}');
      }
      try {
        _key = BToolOptionKey.values.firstWhere((e) => e.name == res.rest[1]);
      } catch (e) {
        throw BToolException('Unknown key: ${res.rest[1]}');
      }
      _args = res.rest.sublist(2);
      if (_args.isNotEmpty) {
        _value = _args.elementAt(0);
      }
    } else {
      print(parser.usage);
      exit(1);
    }

    return BToolOptions(key: _key, action: _action, args: _args, value: _value);
  }
}

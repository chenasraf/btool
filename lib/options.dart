import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

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
  final Directory? workingDir;

  static ArgParser? _parser;

  ArgResults parseResult;

  BToolOptions._({
    required this.key,
    required this.action,
    required this.parseResult,
    this.args = const [],
    this.value,
    this.workingDir,
  });

  factory BToolOptions.fromArgs(
    Iterable<String> args, {
    FileSystem? fs,
  }) {
    final _fs = fs ?? const LocalFileSystem();
    BToolOptionKey _key;
    BToolAction _action;
    Iterable<String>? _args;
    String? _value;

    final res = parser.parse(args);

    // <get/set> <key> [<value?>]
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
    } else if (res['version'] != true && res['help'] != true) {
      throw BToolOptionsException('Bad arguments');
    } else {
      return BToolOptions._(
        key: BToolOptionKey.applicationId,
        action: BToolAction.get,
        parseResult: res,
        workingDir: res['working-dir'] != null ? _fs.directory(res['working-dir']) : null,
      );
    }

    return BToolOptions._(
      key: _key,
      action: _action,
      args: _args,
      value: _value,
      workingDir: res['working-dir'] != null ? _fs.directory(res['working-dir']) : null,
      parseResult: res,
    );
  }

  static ArgParser get parser {
    if (BToolOptions._parser != null) {
      return BToolOptions._parser!;
    }

    final _parser = ArgParser(allowTrailingOptions: true);
    _parser.addFlag('help', abbr: 'h', negatable: false, help: 'Show help');
    _parser.addFlag('version', abbr: 'v', negatable: false, help: 'Show version');
    _parser.addOption('working-dir', abbr: 'd', help: 'Change working directory of script');
    _parser.addFlag('verbose', abbr: 'V', negatable: false, help: 'Display debug output');
    BToolOptions._parser = _parser;
    return _parser;
  }

  static String get usage {
    const pad = 21;
    return [
      'Usage: btool <command> [...args]',
      '',
      'Commands:',
      '',
      '${'get <key>'.padRight(pad)}Get config value',
      '${'set <key> <value>'.padRight(pad)}Set config value',
      '',
      'Available keys:',
      '',
      BToolOptionKey.values.map((x) => '- ${x.name}').join('\n'),
      '',
      'Optional flags:',
      '',
      BToolOptions.parser.usage,
    ].join('\n');
  }
}

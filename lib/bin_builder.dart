import 'dart:async';

import 'package:build/build.dart';
import 'package:btool/pubspec_utils.dart';

class BinBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final contents = await buildStep.readAsString(buildStep.inputId);
    return buildStep.writeAsString(
      buildStep.inputId.changeExtension('.bin.dart'),
      contents.replaceAll('{{VERSION}}', getPackageVersion()),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.bin.dart'],
      };
}

Builder binBuilder(BuilderOptions options) {
  print("OPTIONS");
  print(options);
  return BinBuilder();
}

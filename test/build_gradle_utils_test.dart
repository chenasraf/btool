import 'package:btool/build_gradle_utils.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('build_gradle_utils', () {
    late FileSystem fs;
    setUp(() {
      fs = MemoryFileSystem();
      var dir =
          path.join(fs.currentDirectory.path, 'android', 'app', 'build.gradle');
      fs.directory(path.dirname(dir)).createSync(recursive: true);
      fs
          .file(
            dir,
          )
          .writeAsStringSync(
            [
              'defaultConfig {',
              '    applicationId "com.example.app"',
              '    // You can update the following values to match your application needs.',
              '    // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration.',
              '    minSdkVersion flutter.minSdkVersion',
              '    // minSdkVersion 19',
              '    targetSdkVersion flutter.targetSdkVersion',
              '    versionCode flutterVersionCode.toInteger()',
              '    versionName flutterVersionName',
              '}',
            ].join('\n'),
          );
    });

    group('minSdkVersion', () {
      test('get', () {
        final ver = getMinSdkVersion(fs: fs);
        expect(ver, 'flutter.minSdkVersion');
      });

      test('set', () {
        setMinSdkVersion('21', fs: fs);
        final ver = getMinSdkVersion(fs: fs);
        expect(ver, '21');
      });
    });

    group('targetSdkVersion', () {
      test('get', () {
        final ver = getTargetSdkVersion(fs: fs);
        expect(ver, 'flutter.targetSdkVersion');
      });

      test('set', () {
        setTargetSdkVersion('31', fs: fs);
        final ver = getTargetSdkVersion(fs: fs);
        expect(ver, '31');
      });
    });

    group('applicationId', () {
      test('get', () {
        final ver = getApplicationId(fs: fs);
        expect(ver, 'com.example.app');
      });

      test('set', () {
        setApplicationId('com.dev.my_app', fs: fs);
        final ver = getApplicationId(fs: fs);
        expect(ver, 'com.dev.my_app');
      });
    });
  });
}

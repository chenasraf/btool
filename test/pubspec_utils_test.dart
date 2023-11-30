import 'package:btool/pubspec_utils.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('pubspec_utils', () {
    late FileSystem fs;
    setUp(() {
      fs = MemoryFileSystem();
      fs.file(path.join(fs.currentDirectory.path, 'pubspec.yaml')).writeAsStringSync(
            [
              'name: test_app',
              'version: 1.0.0+1',
            ].join('\n'),
          );
    });
    group('package version', () {
      test('get', () {
        final ver = getPackageVersion(fs: fs);
        expect(ver, '1.0.0+1');
      });

      test('set', () {
        setPackageVersion('2.0.0+2', fs: fs);
        final ver = getPackageVersion(fs: fs);
        expect(ver, '2.0.0+2');
      });
    });

    group('package name', () {
      test('get', () {
        final ver = getPackageName(fs: fs);
        expect(ver, 'test_app');
      });

      test('set', () {
        setPackageName('actual_app', fs: fs);
        final ver = getPackageName(fs: fs);
        expect(ver, 'actual_app');
      });
    });
  });
}

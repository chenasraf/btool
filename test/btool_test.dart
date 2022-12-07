import 'package:btool/btool.dart';
import 'package:btool/options.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';

void main() {
  late FileSystem fs;
  setUp(() {
    fs = MemoryFileSystem();
  });

  group('getAction', () {
    test('get command', () {
      final options = BToolOptions.fromArgs(['get', 'packageVersion']);
      final res = getAction(options, fs: fs);
      expect(res.action, BToolAction.get);
    });

    test('set command', () {
      final options = BToolOptions.fromArgs(['set', 'packageVersion', '1.0.0']);
      final res = getAction(options, fs: fs);
      expect(res.action, BToolAction.set);
      expect(res.value, '1.0.0');
    });
  });
}

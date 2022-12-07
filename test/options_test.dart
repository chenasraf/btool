import 'package:btool/options.dart';
import 'package:test/test.dart';

void main() {
  group('BToolOptions', () {
    test('get command', () {
      final res = BToolOptions.fromArgs(['get', 'packageVersion']);
      expect(res.key, BToolOptionKey.packageVersion);
      expect(res.action, BToolAction.get);
    });

    test('set command', () {
      final res = BToolOptions.fromArgs(['set', 'packageVersion', '1.0.0']);
      expect(res.key, BToolOptionKey.packageVersion);
      expect(res.action, BToolAction.set);
      expect(res.args, ['1.0.0']);
      expect(res.value, '1.0.0');
    });
  });
}

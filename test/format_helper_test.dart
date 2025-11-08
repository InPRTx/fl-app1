import 'package:fl_app1/helper/format_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Traffic Format Helper Tests', () {
    group('formatBytes', () {
      test('应该正确格式化字节数', () {
        expect(formatBytes(0), '0 B');
        expect(formatBytes(1024), '1.00 KB');
        expect(formatBytes(1048576), '1.00 MB');
        expect(formatBytes(1073741824), '1.00 GB');
        expect(formatBytes(1099511627776), '1.00 TB');
      });

      test('应该正确处理小数', () {
        expect(formatBytes(1536), '1.50 KB');
        expect(formatBytes(11274289152), '10.50 GB');
      });

      test('应该正确处理负数和零', () {
        expect(formatBytes(-100), '0 B');
        expect(formatBytes(0), '0 B');
      });
    });

    group('parseBytes', () {
      test('应该正确解析人类可读格式', () {
        expect(parseBytes('1024 B'), 1024);
        expect(parseBytes('1 KB'), 1024);
        expect(parseBytes('1 MB'), 1048576);
        expect(parseBytes('1 GB'), 1073741824);
        expect(parseBytes('1 TB'), 1099511627776);
      });

      test('应该处理小数', () {
        expect(parseBytes('1.5 KB'), 1536);
        expect(parseBytes('10.5 GB'), 11274289152);
      });

      test('应该处理大小写', () {
        expect(parseBytes('1 kb'), 1024);
        expect(parseBytes('1 Kb'), 1024);
        expect(parseBytes('1 KB'), 1024);
      });

      test('应该处理空格', () {
        expect(parseBytes('1KB'), 1024);
        expect(parseBytes('1 KB'), 1024);
        expect(parseBytes('  1  KB  '), 1024);
      });

      test('应该处理无效输入', () {
        expect(parseBytes(''), null);
        expect(parseBytes('abc'), null);
        expect(parseBytes('1 XB'), null);
      });
    });

    group('双向转换', () {
      test('formatBytes -> parseBytes 应该得到相同的值', () {
        final testValues = [1024, 1048576, 1073741824, 11274289152];

        for (final value in testValues) {
          final formatted = formatBytes(value);
          final parsed = parseBytes(formatted);
          expect(parsed, closeTo(value, value * 0.01));
        }
      });

      test('parseBytes -> formatBytes 应该得到相似的字符串', () {
        final testStrings = ['1 KB', '1 MB', '1 GB', '10.5 GB'];

        for (final str in testStrings) {
          final parsed = parseBytes(str);
          expect(parsed, isNotNull);
          final formatted = formatBytes(parsed!);
          expect(formatted, isNotEmpty);
        }
      });
    });
  });
}

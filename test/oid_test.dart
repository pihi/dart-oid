import 'package:oid/oid.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Oid oid1;
    Oid oid2;
    Oid oid3;

    setUp(() {
      oid1 = new Oid('1.2.3.4.5');
      oid2 = new Oid('1.2.3.4');
      oid3 = new Oid('1.2.3');
    });

    test('Newly constructed oid is identical', () {
      expect(oid1, equals(new Oid('1.2.3.4.5')));
      expect(oid2, equals(new Oid('1.2.3.4')));
      expect(oid3, equals(new Oid('1.2.3')));
    });

    test('Child oid is identical', () {
      expect(oid1, equals(oid2.getChild(5)));
      expect(oid2, equals(oid3.getChild(4)));
    });

    test('isChildOf works', () {
      expect(oid1.isChildOf(oid2), isTrue);
      expect(oid2.isChildOf(oid3), isTrue);
      expect(oid1.isChildOf(oid3), isTrue);
      expect(oid1.isChildOf(oid1), isFalse);
      expect(oid1.isChildOf(new Oid("2")), isFalse);
    });

    test('isLeaf works', () {
      expect(oid1.isLeaf, isTrue);
      expect(oid2.isLeaf, isFalse);
      expect(oid3.isLeaf, isFalse);
    });
  });
}

import 'dart:math';

class BaseId {
  static var _count = 1;
  static var _random = Random();

  static String getId() {
    final c = _count++;
    final r = _random.nextInt(100000);
    final t = DateTime.now().millisecond;
    return "${c}_${r}_$t";
  }
}

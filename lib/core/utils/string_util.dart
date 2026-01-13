import 'dart:math';

class StringUtil {
  static String generateRandomString() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(5, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}

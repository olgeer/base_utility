import 'dart:convert';
import 'logger.dart';
import 'utils.dart';

/// 独特的可逆转码类
/// 可以给定key值增加编码的个性
/// 可通过更改 MIX_STR 和 chgTemple 值来定制特定的转码
/// 可以通过设置 debugMode 为true显示中间结果
class Encrypt {
  static bool debugMode = false;
  static final String BASE_64_STR =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

  static final String MIX_STR =
      'vw01xHMAJsB9+C4aiNOj5bV78/-DpItueKLqgh6WXcdPQRyzFGSEnoTUrfYZklm23';

  static final List<List<int>> chgTemple = [
    [4, 6, 5, 0, 2, 1, 3],
    [3, 2, 5, 1, 6, 4, 0],
    [5, 1, 3, 6, 4, 0, 2],
    [6, 2, 1, 0, 5, 3, 4],
    [1, 5, 4, 6, 2, 0, 3],
    [5, 2, 3, 1, 6, 4, 0]
  ];

  static int getSumValue(String key) {
    int sumValue = 0;
    List<int> k = key.codeUnits;
    for (int b in k) {
      sumValue += b;
      sumValue = sumValue % 64;
    }
    return sumValue;
  }

  static int findCharIndex(int c, List<int> map) {
    int index = 0;

    for (int i = 0; i < map.length; i++) {
      if (map[i] == c) {
        index = i;
        break;
      }
    }

    return index;
  }

  static String mixcode(String incode, String key) {
    int skipInterval = getSumValue(key);
    List<int> tmp = incode.codeUnits.toList();
    for (int i = 0; i < tmp.length; i++) {
      tmp[i] = MIX_STR.codeUnitAt(
          (findCharIndex(tmp[i], BASE_64_STR.codeUnits) + skipInterval) % 65);
    }
    return String.fromCharCodes(tmp);
  }

  static String fixcode(String mixedcode, String key) {
    int skipInterval = getSumValue(key);
    List<int> tmp = mixedcode.codeUnits.toList();
    for (int i = 0; i < tmp.length; i++) {
      tmp[i] = BASE_64_STR.codeUnitAt(
          (findCharIndex(tmp[i], MIX_STR.codeUnits) + 65 - skipInterval) % 65);
    }
    return String.fromCharCodes(tmp);
  }

  static String templeEncode(String srcStr) {
    int sumValue = getSumValue(srcStr);
    List<String>? splits = split(srcStr, chgTemple[0].length);
    int templeId = sumValue % chgTemple.length;

    List<String> retArray = List<String>.filled(splits.length, "");
    for (int p = 0; p < chgTemple[0].length; p++) {
      retArray[p] = splits[chgTemple[templeId][p]];
    }
    retArray[splits.length - 1] = splits[splits.length - 1];
    return concat(retArray);
  }

  static String templeDecode(String srcStr) {
    int sumValue = getSumValue(srcStr);
    List<String>? splits = split(srcStr, chgTemple[0].length);
    int templeId = sumValue % chgTemple.length;

    List<String> retArray = List<String>.filled(splits.length, "");
    for (int p = 0; p < chgTemple[0].length; p++) {
      retArray[chgTemple[templeId][p]] = splits[p];
    }
    retArray[splits.length - 1] = splits[splits.length - 1];
    return concat(retArray);
  }

  static String encode(String text, String key) {
    // logger.fine( "orgCode:$text");
    String encoded = base64Encode(text.codeUnits);
    // logger.fine( "base64Code:" + encoded);
    String mixedCode = mixcode(templeEncode(encoded), key);
    if (debugMode) logger.fine("encoded:" + mixedCode);
    return mixedCode;
  }

  static String decode(String ciphertext, String key) {
    // logger.fine( "mixCode:" + ciphertext);
    String fixedCode = templeDecode(fixcode(ciphertext, key));
    // logger.fine( "fixedCode:" + fixedCode);
    String decoded = utf8.decode(base64Decode(fixedCode));
    if (debugMode) logger.fine("decoded:" + decoded);
    return decoded;
  }
}

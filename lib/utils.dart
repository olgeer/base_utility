import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:dio/adapter.dart';
import 'package:hash/hash.dart' as hash;
import 'package:path/path.dart' as p;
import 'logger.dart';
import 'define.dart';

String genKey({int lenght = 24}) {
  const randomChars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F'
  ];
  String key = "";
  for (int i = 0; i < lenght; i++) {
    key += randomChars[Random().nextInt(randomChars.length)];
  }
  return key;
}

String str2hex(String str) {
  const hex2char = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F'
  ];
  String hexStr = "";
  // if (str != null) {
  for (int i = 0; i < str.length; i++) {
    int ch = str.codeUnitAt(i);
    hexStr += hex2char[(ch & 0xF0) >> 4];
    hexStr += hex2char[ch & 0x0F];
//      logger.fine("hexStr:[$hexStr]");
  }
  // } else {
  //   throw new Exception("Param string is null");
  // }
  return hexStr;
}

String Uint8List2HexStr(Uint8List uint8list) {
  const hex2char = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F'
  ];
  String hexStr = "";
  // if (uint8list != null) {
  for (int i in uint8list) {
    hexStr += hex2char[(i & 0xF0) >> 4];
    hexStr += hex2char[i & 0x0F];
  }
  // } else {
  //   throw new Exception("Param Uint8List is null");
  // }
  return hexStr;
}

String? size2human(double size) {
  String unit;
  double s = size;
  if (size != -1) {
    int l;
    if (size < 1024) {
      l = 0;
    } else if (size < 1024 * 1024) {
      l = 1;
      s = size / 1024;
    } else {
      for (l = 2; size >= 1024 * 1024; l++) {
        size = size / 1024;
        if ((size / 1024) < 1024) {
          s = size / 1024;
          break;
        }
      }
    }

    switch (l) {
      case 0:
        unit = "Byte";
        break;
      case 1:
        unit = "KB";
        break;
      case 2:
        unit = "MB";
        break;
      case 3:
        unit = "GB";
        break;
      case 4:
        //??????????????????????????????
        unit = "TB";
        break;
      default:
        //ER????????????
        unit = "ER";
    }

    String format = s.toStringAsFixed(1);
    return format + unit;
  }
  return null;
}

String str2Regexp(String str) {
  final List<String> encode = [
    '.',
    '\\',
    '(',
    ')',
    '[',
    ']',
    '+',
    '*',
    '^',
    '\$',
    '?',
    '{',
    '}',
    '|',
    '-',
  ];
  String tmp = "";

  for (int i = 0; i < str.length; i++) {
    String c = str.substring(i, i + 1);
    for (String s in encode) {
      if (s.compareTo(c) == 0) {
        tmp += '\\';
        break;
      }
    }
    tmp += c;
  }
  // for(String s in encode){
  //   tmp=tmp.replaceAll(s, '\\'+s);
  // }
  return tmp;
}

String? fixJsonFormat(String? json) {
  return json?.replaceAll("\\", "\\\\");
}

String double2percent(double d) =>
    ((d * 10000).floor() / 100).toStringAsFixed(2);

String languageCode2Text(String code) {
  Map<String, String> transMap = {"zh": "??????", "en": "English"};
  return transMap[code] ?? "??????";
}

String shortString(String content, {int limit = 200}) {
  String ret = content;
  if (ret.length > limit) ret = "${ret.substring(0, limit)} ... ";
  return ret;
}

Map<String, dynamic> cmdLowcase(dynamic ac) {
  Map<String, dynamic> newAc = {};
  Map.castFrom(ac as Map<String, dynamic>).forEach((key, value) {
    newAc.putIfAbsent((key as String).toLowerCase(), () => value);
  });
  return newAc;
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

String dateTime() => DateTime.now().toString();

int nowInt() => DateTime.now().millisecondsSinceEpoch;

String? sha512(String filePath) {
  File orgFile = File(filePath);
  if (!orgFile.existsSync()) return null;

  Uint8List orgBytes = orgFile.readAsBytesSync();
  Uint8List shaBytes = hash.SHA512().update(orgBytes).digest();
  // logger.fine("sha512($filePath)=[${shaBytes.toString()}]");
  return Uint8List2HexStr(shaBytes);
}

String? md5(String? str) {
  if (str == null) return null;
  Uint8List md5Bytes = hash.MD5().update(str.codeUnits).digest();
  //logger.fine("md5($str)=${md5Bytes}");
  return Uint8List2HexStr(md5Bytes);
}

bool isWorkday(DateTime now) {
  if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday)
    return false;
  return true;
}

String int2Str(int value, {int width = 2}) {
  String s = value.toString();
  for (int i = 0; i < (width - s.length); i++) {
    s = "0" + s;
  }
  return s;
}

String? filterWebDescribe(String? html) {
  if (html == null) return null;
  return html
      .replaceAll("&nbsp;", " ")
      .replaceAll(RegExp('<(\\S*?)>[^<]*</\\1>'), "")
      .replaceAll(RegExp('<[^>]*>'), "")
      .replaceAll("\r", "")
      .replaceAll("\n", "")
      .trim();
}

String filterWebText(String html) {
  return html
      .replaceAll("&nbsp;", " ")
      .replaceAll(RegExp('<(\\S*?)>[^<]*</\\1>'), "")
      .replaceAll(RegExp('<[^>]*>'), "")
      .replaceAll("\r", "")
      // .replaceAll("\n", "")
      .trim();
}

String getFileName(String path) => p.basenameWithoutExtension(path);

String getFullFileName(String path) => p.basename(path);

String getFileExtname(String path) => p.extension(path);

bool fileRename(String beforeName, String afterName) {
  File beforeFile = File(beforeName);
  // logger.fine( "Ready rename\n$beforeName\n to \n$afterName");
  if (beforeFile.existsSync()) {
    beforeFile.renameSync(afterName);
    logger.fine("Renamed\n$beforeName\n to \n$afterName");
    return true;
  }
  return false;
}

void save2File(String filename, String content,
    {FileMode fileMode = FileMode.append, Encoding encoding = utf8}) {
  logger.finer("Save file:$filename");

  File saveFile = File(filename);

  if (!saveFile.existsSync()) saveFile.createSync(recursive: true);

  saveFile.writeAsStringSync(content,
      mode: fileMode, encoding: encoding, flush: true);
}

String? read4File(dynamic file) {
  late File readFile;
  if (file is String) readFile = File(file);
  if (file is File) readFile = file;
  if (readFile.existsSync()) {
    try {
      return readFile.readAsStringSync(encoding: Utf8Codec());
    } catch (e) {
      return null;
    }
  } else
    return null;
}

String getCurrentPath() {
  return Directory.current.path;
}

String strLowcase(dynamic str) {
  // String ret=((str as String)??"").toLowerCase();
  return (str as String).toLowerCase();
}

Encoding getEncoding(String charset) {
  return "utf8".compareTo(strLowcase(charset)) == 0 ? utf8 : gbk;
}

Future<Response?> getUrlFile(String url,
    {int retry = 3, int seconds = 3, bool debugMode = false}) async {
  Response? tmp;
  Dio? dio;

  if (dio == null)
    dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));

  if (debugMode)
    dio.interceptors.add(LogInterceptor(request: true, responseHeader: true));

  do {
    try {
      tmp = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
    } catch (e) {
      if (e is DioError) {
        // logger.warning("DioErrorType : ${e.type.toString()}");
        switch (e.type) {
          case DioErrorType.receiveTimeout:
            logger.warning("Receive Timeout! When get file $url . Retry ...");
            await Future.delayed(Duration(seconds: seconds));
            break;
          case DioErrorType.connectTimeout:
            logger.warning("Connect Timeout! When get file $url . Retry ...");
            await Future.delayed(Duration(seconds: seconds));
            break;
          case DioErrorType.response:
            switch (e.response?.statusCode ?? 505) {
              case 404:
                logger.warning("$url not found. [404]");
                retry = 0;
                break;
              case 500:
                logger.warning("$url background service error. [500]");
                retry = 0;
                break;
              default:
                logger.warning(
                    "StatusCode:[${e.response?.statusCode ?? "505"}] get file [$url] error:${e.message} ");
                await Future.delayed(Duration(seconds: seconds));
                break;
            }
            break;
          default:
            logger.warning(
                "DioErrorType : ${e.type}], get file [$url] error : ${e.message}");
            await Future.delayed(Duration(seconds: seconds));
        }
      }
    }
  } while ((tmp == null || (tmp.statusCode ?? 0) != 200) && --retry > 0);

  return (tmp?.statusCode ?? 0) == 200 ? tmp : null;
}

Future<String?> saveUrlFile(String url,
    {String? saveFileWithoutExt,
    String? savePath,
    FileMode fileMode = FileMode.write,
    int retry = 3,
    int seconds = 3}) async {
  // if (tmpResp.data > 0) {
  List<String> tmpSpile = url.split("//")[1].split("/");
  String? fileExt;
  if (tmpSpile.last.length > 0 && tmpSpile.last.split(".").length > 1) {
    if (saveFileWithoutExt == null || saveFileWithoutExt.length == 0) {
      saveFileWithoutExt =
          (savePath ?? getCurrentPath()) + "/" + tmpSpile.last.split(".")[0];
    }
    fileExt = tmpSpile.last.split(".")[1];
  } else {
    if (saveFileWithoutExt == null || saveFileWithoutExt.length == 0) {
      saveFileWithoutExt = genKey(lenght: 12);
    }
  }

  File urlFile = File("$saveFileWithoutExt.${fileExt ?? ""}");
  if (urlFile.existsSync() && fileMode == FileMode.write) {
    urlFile.deleteSync();
  }
  if (!urlFile.existsSync()) {
    Response? tmpResp = await getUrlFile(url, retry: retry, seconds: seconds);
    if (tmpResp != null) {
      if (fileExt == null) {
        fileExt = tmpResp.headers.value('Content-Type')?.split("/")[1];
        urlFile = File("$saveFileWithoutExt.${fileExt ?? ""}");
      }

      logger.finer("File:${urlFile.path}");

      urlFile.createSync(recursive: true);
      urlFile.writeAsBytesSync(tmpResp.data.toList(),
          mode: fileMode, flush: true);

      logger.fine("Save $url to ${urlFile.path} is OK !");
    } else {
      logger.warning("--Download $url is failed !");
      return null;
    }
  } else {
    logger.fine("Not save $url to ${urlFile.path} because it was existed !");
  }
  return urlFile.path;
}

typedef FutureCall = Future<Response?> Function();

Future<Response?> call(FutureCall retryCall,
    {int retryTimes: 3, int seconds = 2}) async {
  Response? resp;
  do {
    retryTimes--;
    try {
      resp = await retryCall();
      //await Future.delayed(Duration(milliseconds: downloadSleepDuration));
    } catch (e) {
      print("Response error[$retryTimes]:$e");
      await Future.delayed(Duration(seconds: seconds));
    }
  } while (resp == null && retryTimes > 0);
  return resp;
}

Future<String?> getHtml(String sUrl,
    {Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? body,
    RequestMethod method = RequestMethod.get,
    Encoding encoding = utf8,
    int retryTimes = 3,
    int seconds = 5,
    String? debugId,
    bool debugMode = false}) async {
  Dio? dio;
  String? html;
  // Logger().debug("getHtml-[${debugId ?? ""}]", "Ready getHtml: [$sUrl]");
  // logger.fine("$body");

  if (dio == null)
    dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      sendTimeout: 2000,
    ));

  if (debugMode) {
    dio.interceptors.add(LogInterceptor(request: true, responseHeader: true));
  }

  //??????ssl?????????????????????????????????
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) {
      return true;
    };
  };

  Response? listResp = await call(
          () async {
    try {
      if (method == RequestMethod.get) {
        return await dio!.get(sUrl,
            queryParameters: queryParameters,
            options:
                Options(headers: headers, responseType: ResponseType.bytes));
      } else {
        return await dio!.post(sUrl,
            // queryParameters: queryParameters,
            options: Options(
              headers: headers,
                  responseType: ResponseType.bytes,
                  // contentType: "application/x-www-form-urlencoded"
                ),
                data: body);
          }
        } catch (e) {
          if (e is DioError &&
              e.response?.statusCode == 302 &&
              e.response?.headers["location"] != null) {
            try {
              String newUrl = e.response!.headers["location"]!.first;
              newUrl =
                  "${newUrl.contains("http") ? "" : getDomain(sUrl)}$newUrl";
              logger.finer("status code:302 and redirect to $newUrl");
              return await dio!.get(newUrl, options: Options(responseType: ResponseType.bytes));
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        // print(e);
        return null;
      }
    }
  }, seconds: seconds, retryTimes: retryTimes);

  if (listResp != null && listResp.statusCode == 200) {
    try {
      html = encoding.decode(listResp.data);
    } catch (e) {
      // if(encoding.name.contains("gb") && (Platform.isAndroid||Platform.isIOS)){
      //   html = await CharsetConverter.decode("GB18030",listResp.data);
      // }else{
      logger.warning("Charset decode error");
      return null;
      // }
    }
  }

  return html;
}

String getDomain(String url) {
  return url.replaceAll(url.split("/").last, "");
}

String? fixedLength(String? str, int maxLength,
    {String expandAlert = " ??????",
    String collapseAlert = " ??????",
    bool expandState = false}) {
  if (str != null) {
    if (str.length > maxLength) {
      if (expandState) {
        return "$str$collapseAlert";
      } else {
        return "${str.substring(0, str.length > maxLength ? maxLength : str.length)}$expandAlert";
      }
    } else
      return str;
  } else
    return null;
}

String filterScript(String html) {
  int filterStart = 0, scriptLocal, scriptEnd;
  String filtedHtml = html;
  do {
    scriptLocal = filtedHtml.indexOf("<script", filterStart);
    if (scriptLocal > 0) {
      scriptEnd = filtedHtml.indexOf("</script>", scriptLocal);
      filtedHtml = filtedHtml.substring(0, scriptLocal) +
          filtedHtml.substring(scriptEnd + 9, filtedHtml.length);
      filterStart = scriptLocal;
    }
  } while (scriptLocal > 0);
  largeLog(filtedHtml);
  return filtedHtml;
}

///???separate??????????????????????????????????????????
///??????split("abcdefg",3)??????????????????["abc","def","g"]
List<String> split(String? srcStr, int separate) {
  if (srcStr == null || separate <= 0) return [];

  List<String> splits = [];

  int one = srcStr.length ~/ separate;
  for (int n = 0; n < separate; n++) {
    splits.add(srcStr.substring(n * one, (n + 1) * one));
  }
  if (srcStr.length % separate > 0)
    splits.add(srcStr.substring(separate * one));
  else
    splits.add("");

  return splits;
}

///?????????????????????????????????
///??????concat(["a","b","c"])????????????"abc"
///?????????separate?????????????????????????????????????????????separate
String concat(List<String?> splits, {String separate = ""}) {
  String retStr = "";
  for (int p = 0; p < splits.length; p++) {
    if (splits[p] != null) retStr += splits[p]!;
    if (p < splits.length - 1) retStr += separate;
  }
  return retStr;
}

bool isMobile(String phone) {
  final RegExp exp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  return exp.hasMatch(phone);
}

bool isDigit(String number, {int min = 1, int max = 16}) {
  assert(min > 0 && max > 0);
  assert(max >= min);

  RegExp exp = RegExp(
      '^[1-9]\\d{' + (min - 1).toString() + ',' + (max - 1).toString() + '}\$');

  return exp.hasMatch(number);
}

bool isDigitAndChar(String verifyStr, {int min = 1, int max = 16}) {
  assert(min > 0 && max > 0);
  assert(max >= min);

  RegExp exp =
      RegExp('^[\\d|\\w]{' + min.toString() + ',' + max.toString() + '}\$');

  return exp.hasMatch(verifyStr);
}

bool isPassword(String psw, {int min = 8, int max = 16}) {
  assert(min > 0 && max > 0);
  assert(max >= min);

  RegExp exp =
      // RegExp('^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{' + min.toString() + ',' + max.toString() + '}\$');
      RegExp('^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{' +
          min.toString() +
          ',' +
          max.toString() +
          '}\$');

  return exp.hasMatch(psw);
}

String encode(String value, String magic) {
  List<int> valueBytes = value.codeUnits;
  List<int> magicBytes = magic.codeUnits;
  List<int> tempBytes = [];

  for (int i = 0; i < valueBytes.length; i++) {
    tempBytes.add(valueBytes[i] ^ magicBytes[i % magicBytes.length]);
  }
  return base64.encode(tempBytes);
}

String decode(String value, String magic) {
  List<int> magicBytes = magic.codeUnits;
  List<int> valueBytes = base64.decode(value);
  List<int> tempBytes = [];

  for (int i = 0; i < valueBytes.length; i++) {
    tempBytes.add(valueBytes[i] ^ magicBytes[i % magicBytes.length]);
  }
  return utf8.decode(tempBytes);
}

List<String> objectListToStringList(List<dynamic> listObject) {
  List<String> newListString = [];
  for (dynamic obj in listObject) {
    newListString.add(obj.toString());
  }
  return newListString;
}

List<int> objectListToIntegerList(List<dynamic> listObject) {
  List<int> newListString = [];
  for (dynamic obj in listObject) {
    newListString.add(obj.index);
  }
  return newListString;
}

bool compareGesture(List<int> first, List<int> second) {
  if (first.length != second.length) return false;
  for (int i = 0; i < first.length; i++) {
    if (first[i] != second[i]) return false;
  }
  return true;
}

bool isPhone() => Platform.isIOS || Platform.isAndroid;
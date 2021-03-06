// import 'dart:developer';
import 'package:logging/logging.dart';
import 'package:console/console.dart' as con;

final logger = Logger("System");
final logOutputDevice defaultDevice = ConsoleDevice();

void initLogger(
    {Level logLevel = Level.FINE,
    bool showColor = false,
    List<logOutputDevice>? outputDevices}) {
  const String colorEnd = "{{@end}}";
  const String logNameColor = "{{@dark_blue}}";
  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((event) async {
    String color = "{{@yellow}}";
    final String colorEnd = "{{@end}}";
    switch (event.level.value) {
      case 0:
      case 300:
        color = "{{@light_gray}}";
        break;
      case 400:
        color = "{{@light_magenta}}";
        break;
      case 500:
        color = "{{@green}}";
        break;
      case 700:
      case 800:
        color = "{{@yellow}}";
        break;
      case 900:
        color = "{{@magenta}}";
        break;
      case 1000:
        color = "{{@red}}";
        break;
      case 1200:
      default:
        color = "{{@yellow}}";
        break;
    }
    if (event.level >= logLevel) {
      String logmsg = "";
      if (showColor) {
        logmsg = con.format(
            "${DateTime.now().toString()} - $logNameColor[${event.loggerName}]$colorEnd - $color${event.level.toString()}$colorEnd : $color${event.message}$colorEnd",
            style: con.VariableStyle.DOUBLE_BRACKET);
      } else {
        logmsg =
            "${DateTime.now().toString()} - [${event.loggerName}] - ${event.level.toString()} : ${event.message}";
      }
      if (outputDevices != null) {
        if (outputDevices.isNotEmpty) {
          for (logOutputDevice oneDevice in outputDevices) {
            await oneDevice.output(logmsg);
          }
        } else {
          await defaultDevice.output(logmsg);
        }
      } else {
        await defaultDevice.output(logmsg);
      }
    }
  });
}

void largeLog(dynamic msg, {Logger? logHandle, Level level = Level.FINER}) {
  String str;
  final int maxPrintLength = 511;
  if (logHandle == null) logHandle = logger;

  if (!(msg is String)) {
    str = msg.toString();
  } else {
    str = msg;
  }

  for (String oneLine in str.split("\n")) {
    while (oneLine.length > maxPrintLength) {
      logHandle.log(level, oneLine.substring(0, maxPrintLength));
      oneLine = oneLine.substring(maxPrintLength);
    }
    logHandle.log(level, oneLine);
  }
}

abstract class logOutputDevice {
  logOutputDevice init();

  Future<void> output(String log);

  void dismiss();
}

class ConsoleDevice implements logOutputDevice {
  @override
  ConsoleDevice init() {
    return this;
  }

  @override
  void dismiss() {}

  @override
  Future<void> output(String log) async {
    print(log);
  }
}

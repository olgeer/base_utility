import 'dart:convert';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils.dart';

///设置屏幕旋转使能状态
void setRotateMode({bool canRotate = true}) {
  if (canRotate) {
    AutoOrientation.fullAutoMode();
  } else {
    AutoOrientation.portraitUpMode();
  }
  // Logger().debug("NovelReader", "canRotate:$canRotate");
}

Future<void> upgradeApk(String url, {String? fileName}) async {
  await RUpgrade.upgrade(url,
      fileName: fileName, isAutoRequestInstall: true, useDownloadManager: true);
}

int rgbCalc(int value, int change) {
  int t = value + change;
  if (t < 0) t = 0;
  if (t > 255) t = 255;
  return t;
}

Color shade(Color originColor, int level) {
  return Color.fromARGB(
      originColor.alpha,
      rgbCalc(originColor.red, level * 30),
      rgbCalc(originColor.green, level * 30),
      rgbCalc(originColor.blue, level * 30));
}

Future<String> read4Asset(String assetPath) async {
  return await rootBundle.loadString(assetPath);
}

Future<String?> readResource(String resUri) async {
  return resUri.startsWith("http")
      ? await getHtml(resUri)
      : resUri.startsWith("file")
          ? read4File(resUri)
          : await read4Asset(resUri);
}

Future<dynamic> getJsonResource(String resUri) async {
  return jsonDecode((await readResource(resUri)) ?? "{}");
}

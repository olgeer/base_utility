import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:unique_ids/unique_ids.dart';
import 'package:device_information/device_information.dart';
import 'utils.dart';

Future<Map<String, dynamic>> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData;

  try {
    if (Platform.isAndroid) {
      deviceData =
          await _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = await _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    } else {
      deviceData = {};
    }
  } on PlatformException {
    deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
  }
  String imei = isPhone() ? await DeviceInformation.deviceIMEINumber : "";
  // String imei=await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);
//  List<String> multiImei = await ImeiPlugin.getImeiMulti();
//  deviceData.addAll(<String, dynamic>{"imei":multiImei.toString()});
  deviceData.addAll(<String, dynamic>{"imei": imei});
  print("DeviceInfo:$imei");
  print(deviceData);
  return deviceData;
}

Future<Map<String, dynamic>> _readAndroidBuildData(
    AndroidDeviceInfo build) async {
  return <String, dynamic>{
    'platform': 'android',
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
    'UniqueDeviceIdentifier': null,
    'UniversallyUniqueIdentifier': await UniqueIds.uuid,
    'ADvanceIDentification': await UniqueIds.adId,
  };
}

Future<Map<String, dynamic>> _readIosDeviceInfo(IosDeviceInfo data) async {
  return <String, dynamic>{
    'platform': 'ios',
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
    'UniqueDeviceIdentifier': null,
    'UniversallyUniqueIdentifier': await UniqueIds.uuid,
    'ADvanceIDentification': await UniqueIds.adId,
  };
}

dynamic getDeviceByStandName(Map<String, dynamic> dInfo, String key) {
  var value;
  bool isAndroid = "android".compareTo(dInfo["platform"]) == 0;
  switch (key) {
    case "osVersion":
      value = isAndroid
          ? "A${dInfo["version.sdkInt"]}"
          : "I${dInfo["systemVersion"]}";
      break;
    case "imei":
      value = isAndroid ? dInfo["imei"] : "";
      break;
    case "model":
      value = dInfo["model"];
      break;
    case "sn":
      value =
          isAndroid ? dInfo["androidId"] : dInfo["UniversallyUniqueIdentifier"];
      break;
    default:
      break;
  }
  return value;
}

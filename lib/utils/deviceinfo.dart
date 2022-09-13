// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooldesklight/models/useraccounts.dart';

class DeviceInfo {
  String? serialNumber = "";
  String? sessionHostId = "";
  String? hostName = "";
  String? hostMAC = "";
  String? loginProvider = "";
  String? providerKey = "";
  String? lastSeen = "";
  String? publicIP = "";
  String? localIP = "";
  String? notificationToken = "";
  String? versionSecurityPatch = "";
  int? versionSdkInt = 0;
  String? versionRelease = "";
  int? versionPreviewSdkInt = 0;
  String? versionIncremental = "";
  String? versionCodename = "";
  String? versionBaseOS = "";
  String? securityPatch = "";
  String? board = "";
  String? brand = "";
  String? device = "";
  String? display = "";
  String? fingerprint = "";
  String? manufacturer = "";
  String? model = "";
  String? product = "";
  String? type = "";
  bool? isPhysicalDevice = true;
  String? alert = "";
  DeviceInfo({
    this.serialNumber,
    this.sessionHostId,
    this.hostName,
    this.hostMAC,
    this.loginProvider,
    this.providerKey,
    this.lastSeen,
    this.publicIP,
    this.localIP,
    this.notificationToken,
    this.versionSecurityPatch,
    this.versionSdkInt,
    this.versionRelease,
    this.versionPreviewSdkInt,
    this.versionIncremental,
    this.versionCodename,
    this.versionBaseOS,
    this.securityPatch,
    this.board,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.manufacturer,
    this.model,
    this.product,
    this.type,
    this.isPhysicalDevice,
    this.alert,
  });
}

Future<DeviceInfo> userDeviceInformation() async {
  try {
    showLoader();
    var deviceInfo = DeviceInfo();

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (kIsWeb) {
      //deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
    } else {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceInfo.securityPatch = build.version.securityPatch;
        deviceInfo.versionSdkInt = build.version.sdkInt;
        deviceInfo.versionRelease = build.version.release;
        deviceInfo.versionPreviewSdkInt = build.version.previewSdkInt;
        deviceInfo.versionIncremental = build.version.incremental;
        deviceInfo.versionCodename = build.version.codename;
        deviceInfo.versionBaseOS = build.version.baseOS;
        deviceInfo.board = build.board;
        deviceInfo.brand = build.brand;
        deviceInfo.device = build.device;
        deviceInfo.display = build.display;
        deviceInfo.fingerprint = build.fingerprint;
        deviceInfo.hostName = build.host;
        deviceInfo.serialNumber = build.id;
        deviceInfo.manufacturer = build.manufacturer;
        deviceInfo.model = build.model;
        deviceInfo.product = build.product;
        deviceInfo.isPhysicalDevice = build.isPhysicalDevice;
        return deviceInfo;
      } else if (Platform.isIOS) {
        hideLoader();
        // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);

      } else if (Platform.isLinux) {
        
        //deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
      } else if (Platform.isMacOS) {
      
        //deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
      } else if (Platform.isWindows) {
    
        //deviceData = _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
      }
   hideLoader();
      return deviceInfo;
    }
  } on PlatformException {
    return DeviceInfo(alert: "Failed to get platform version.");
    // deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
  }
  return DeviceInfo();
}


// Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
//   return <String, dynamic>{
//     'name': data.name,
//     'systemName': data.systemName,
//     'systemVersion': data.systemVersion,
//     'model': data.model,
//     'localizedModel': data.localizedModel,
//     'identifierForVendor': data.identifierForVendor,
//     'isPhysicalDevice': data.isPhysicalDevice,
//     'utsname.sysname:': data.utsname.sysname,
//     'utsname.nodename:': data.utsname.nodename,
//     'utsname.release:': data.utsname.release,
//     'utsname.version:': data.utsname.version,
//     'utsname.machine:': data.utsname.machine,
//   };
// }

// Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
//   return <String, dynamic>{
//     'name': data.name,
//     'version': data.version,
//     'id': data.id,
//     'idLike': data.idLike,
//     'versionCodename': data.versionCodename,
//     'versionId': data.versionId,
//     'prettyName': data.prettyName,
//     'buildId': data.buildId,
//     'variant': data.variant,
//     'variantId': data.variantId,
//     'machineId': data.machineId,
//   };
// }

// Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
//   return <String, dynamic>{
//     'browserName': describeEnum(data.browserName),
//     'appCodeName': data.appCodeName,
//     'appName': data.appName,
//     'appVersion': data.appVersion,
//     'deviceMemory': data.deviceMemory,
//     'language': data.language,
//     'languages': data.languages,
//     'platform': data.platform,
//     'product': data.product,
//     'productSub': data.productSub,
//     'userAgent': data.userAgent,
//     'vendor': data.vendor,
//     'vendorSub': data.vendorSub,
//     'hardwareConcurrency': data.hardwareConcurrency,
//     'maxTouchPoints': data.maxTouchPoints,
//   };
// }

// Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
//   return <String, dynamic>{
//     'computerName': data.computerName,
//     'hostName': data.hostName,
//     'arch': data.arch,
//     'model': data.model,
//     'kernelVersion': data.kernelVersion,
//     'osRelease': data.osRelease,
//     'activeCPUs': data.activeCPUs,
//     'memorySize': data.memorySize,
//     'cpuFrequency': data.cpuFrequency,
//     'systemGUID': data.systemGUID,
//   };
// }

// Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
//   return <String, dynamic>{
//     'numberOfCores': data.numberOfCores,
//     'computerName': data.computerName,
//     'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
//   };
// }

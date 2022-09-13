import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoredModel {
  String token = "";
  bool isLoggedIn = false;
  bool isAccountActive = true;
  int appUserId = 0;
  String userName = "";
  String fullName = "";
  String email = "";
  String mobile = "";
  String userType = "";
  String profileURL = "";
  String profileImage = "";
  String remoteUId = "";
  String deviceId = "";
  String appUserHash = "";
  String fcmtoken = "";
  LocalStoredModel({
    required this.token,
    required this.isLoggedIn,
    required this.isAccountActive,
    required this.deviceId,
    required this.appUserHash,
    required this.appUserId,
    required this.profileURL,
    required this.remoteUId,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.profileImage,
    required this.userType, 
    required String fcmtoken,
  });
}

// Write DATA
Future<LocalStoredModel> updateUserContext(LocalStoredModel localModel) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setBool('isAccountActive', localModel.isAccountActive);
  await pref.setBool('isLoggedIn', localModel.isLoggedIn);
  await pref.setString('token', localModel.token);
  await pref.setString('appUserHash', localModel.appUserHash);
  await pref.setInt('appUserId', localModel.appUserId);
  await pref.setString('profileURL', localModel.profileURL);
  await pref.setString('remoteUId', localModel.remoteUId);
  await pref.setString('userName', localModel.userName);
  await pref.setString('fullName', localModel.fullName);
  await pref.setString('email', localModel.email);
  await pref.setString('mobile', localModel.mobile);
  await pref.setString('userType', localModel.userType);
  await pref.setString('deviceId', localModel.deviceId);
  await pref.setString('profileImage', localModel.profileImage);
  await pref.setString('fcmtoken', localModel.fcmtoken);
  return getUserContextData();
}

// Read Data
Future<LocalStoredModel> getUserContextData() async {
  var localModel = LocalStoredModel(

      appUserHash: '',
      token: '',
      userName: '',
      fullName: '',
      profileURL: '',
      userType: '',
      appUserId: 0,
      deviceId: '',
      email: '',
      isAccountActive: false,
      isLoggedIn: false,
      mobile: '',
      profileImage: '',
      remoteUId: '',
      fcmtoken: '',
      );
  localModel = await SharedPreferences.getInstance().then((pref) {
    localModel.isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    localModel.isAccountActive = pref.getBool('isAccountActive') ?? false;
    localModel.token = pref.getString('token') ?? "";
    localModel.appUserHash = pref.getString('appUserHash') ?? "";
    localModel.appUserId = pref.getInt('appUserId') ?? 0;
    localModel.profileURL = pref.getString('profileURL') ?? "";
    localModel.remoteUId = pref.getString('remoteUId') ?? "";
    localModel.userName = pref.getString('userName') ?? "";
    localModel.fullName = pref.getString('fullName') ?? "";
    localModel.email = pref.getString('email') ?? "";
    localModel.mobile = pref.getString('mobile') ?? "";
    localModel.userType = pref.getString('userType') ?? "";
    localModel.deviceId = pref.getString('deviceId') ?? "";
    localModel.profileImage = pref.getString('profileImage') ?? "";
    localModel.fcmtoken = pref.getString('fcmtoken') ?? "";
    return localModel;
  });
  return localModel;
}

// delete Data
Future<LocalStoredModel> deleteAllUserContext() async {
  CircularProgressIndicator();
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('isLoggedIn');
  pref.remove('token');
  pref.remove('isAccountActive');
  pref.remove('appUserHash');
  pref.remove('appUserId');
  pref.remove('profileURL');
  pref.remove('remoteUId');
  pref.remove('userName');
  pref.remove('fullName');
  pref.remove('email');
  pref.remove('mobile');
  pref.remove('userType');
  pref.remove('profileImage');
  pref.remove('deviceId');
  pref.remove('fcmtoken');
  return getUserContextData();
}

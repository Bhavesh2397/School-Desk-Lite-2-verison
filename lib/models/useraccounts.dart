import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/deviceinfo.dart';
import '../utils/shared_preferences.dart';
import '../utils/theme.dart';

class UserAccount {
  int appUserId = 0;
  String userName = "";
  String registredEmail = "";
  String email = "";
  String registredMobile = "";
  String mobile = "";
  String userType = "";
  String profileURL = "";
  String remoteUId = "";
  String fullName = "";
  String appUserHash = "";
  String studentHash = "";
  String nickName = "";
  String schoolName = "";
  String gradeLevelName = "";
  String divisionName = "";
  String profileImage = "";
  String token = "";
  String deviceId = '';
  String fcmtoken = '';
  bool sessionRenewalRequired = false;
  String? alert = "";
  UserAccount({
    required this.appUserId,
    required this.userName,
    required this.registredEmail,
    required this.registredMobile,
    required this.userType,
    required this.profileURL,
    required this.remoteUId,
    required this.fullName,
    required this.appUserHash,
    required this.studentHash,
    required this.nickName,
    required this.schoolName,
    required this.gradeLevelName,
    required this.divisionName,
    required this.profileImage,
    required this.mobile,
    required this.token,
    required this.deviceId,
    required this.fcmtoken,
    required this.sessionRenewalRequired,
    this.alert,
  });
  DateTime lastUpdatedOn = DateTime(2000, 08, 10);

  UserAccount.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'] ?? 0;
    userName = json['userName'] ?? "";
    fullName = json['fullName'] ?? "";
    registredEmail = json['registredEmail'] ?? "";
    email = json['email'] ?? "";
    registredMobile = json['registredMobile'] ?? "";
    mobile = json['mobile'] ?? "";
    userType = json['userType'] ?? "";
    profileURL = json['profileURL'] ?? "";
    remoteUId = json['remoteUId'] ?? "";
    fullName = json['fullName'] ?? "";
    studentHash = json['studentHash'] ?? "";
    appUserHash = json['appUserHash'] ?? "";
    nickName = json['nickName'] ?? "";
    schoolName = json['schoolName'] ?? "";
    gradeLevelName = json['gradeLevelName'] ?? "";
    divisionName = json['divisionName'] ?? "";
    profileImage = json['profileImage'] ?? "";
    token = json['token'] ?? "";
    deviceId = json['deviceId'] ?? "";
    sessionRenewalRequired = json['sessionRenewalRequired'] ?? false;
    alert = json['alert'] ?? "";
    fcmtoken = json['fcmtoken'] ?? "";
  }
}

Future<List<UserAccount>> getUserAccountData() async {
  showLoader();
  //await Future.delayed(const Duration(seconds: 2));
  var localStoredModel = await getUserContextData();

  if (localStoredModel.isLoggedIn == false || localStoredModel.token.isEmpty) {
    await deleteAllUserContext();
    return [];
  }
  String? token = localStoredModel.token;
  String? webtoken = localStoredModel.deviceId;
  //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOlsiVXNlciIsIlN0dWRlbnQiXSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IkRlbW8gU3R1ZGVudCAiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJoZWFkaXRAcmJrZWkub3JnIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiI5ODIxMjgzNjU4IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIxMyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvc2VyaWFsbnVtYmVyIjoic3M6ZmY6ZGQ6ZDE6aDQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2F1dGhlbnRpY2F0aW9ubWV0aG9kIjpbIkxvY2FsIiwiTG9jYWwiXSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvc2lkIjoiU3R1ZGVudCIsIlByb2ZpbGVJbWFnZSI6IkIwMDkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ByaW1hcnlzaWQiOiIxMyw0LDAiLCJTdHVkZW50SWQiOiI0IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy91c2VyZGF0YSI6IlN0dWRlbnQiLCJleHAiOjE2OTA2OTU3MzcsImlzcyI6IioiLCJhdWQiOiIqIn0.p2xDwjnW63Yt0Sc-6GkdWENT3pqWMRKA_zYlY94Yu6U';
  var url = Uri.parse('${BaseConfig.baseUrl}api/GetRegisteredAccounts');
  final response = await get(url, headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token"
  });
  if (response.statusCode == 200) {
    hideLoader();

    Map<String, dynamic> jsondata =
        Map<String, dynamic>.from(json.decode(response.body));
    var userAccountData = jsondata['userList'];
    return List.from(userAccountData)
        .map<UserAccount>((item) => UserAccount.fromJson(item))
        .toList();
  } else {
    showLoader();
    return [];
  }
}

Future<UserAccount> createTokan(String userName, String password) async {
  var userAccount = UserAccount(
      token: '',
      appUserHash: "",
      appUserId: 0,
      deviceId: '',
      divisionName: '',
      fullName: '',
      gradeLevelName: '',
      mobile: '',
      nickName: '',
      profileImage: '',
      profileURL: '',
      registredEmail: '',
      registredMobile: '',
      remoteUId: '',
      schoolName: '',
      studentHash: '',
      userName: '',
      userType: '',
      fcmtoken: '',
      sessionRenewalRequired: false);

  try {
    CircularProgressIndicator(
      color: Colors.black12,
      backgroundColor: Colors.amber,
    );
    var deviceInfo = await userDeviceInformation();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${BaseConfig.baseUrl}api/CreateTokan'));
    request.fields.addAll({
      'fcmtoken': 'fcmtoken',
      'UserName': userName,
      'Password': password,
      'SerialNumber': '${deviceInfo.serialNumber}',
      'SessionHostId': 'NewGUID',
      'HostName': '${deviceInfo.hostName}',
      'SerialNumber': '${deviceInfo.serialNumber}',
      'SessionHostId': DateTime.now().microsecondsSinceEpoch.toString(),
      'HostName': '${deviceInfo.hostName}',
      'HostMAC': 'ss:ff:dd:d1:h4',
      'LoginProvider': 'local',
      'ProviderKey': 'jwt',
      'LastSeen': DateTime.now().toString(),
      'PublicIP': '**.**.**.**',
      'LocalIP': '**.**.**.**',
      'NotificationToken': 'dummy'
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      hideLoader();
      Map<String, dynamic> jsondata = Map<String, dynamic>.from(
          json.decode(await response.stream.bytesToString()));

      return UserAccount.fromJson(jsondata);
    }
    return userAccount;
  } catch (e) {
    userAccount.alert = e.toString();
    return userAccount;
  }
}

Future<Object> loggedInUserInfo() async {
  var userAccount = UserAccount(
      fcmtoken: '',
      token: '',
      deviceId: '',
      appUserHash: "",
      appUserId: 0,
      divisionName: '',
      fullName: '',
      gradeLevelName: '',
      mobile: '',
      nickName: '',
      profileImage: '',
      profileURL: '',
      registredEmail: '',
      registredMobile: '',
      remoteUId: '',
      schoolName: '',
      studentHash: '',
      userName: '',
      userType: '',
      sessionRenewalRequired: false);
  try {
    showLoader();
    var localStoredModel = await getUserContextData();

    if (localStoredModel.isLoggedIn == false ||
        localStoredModel.token.isEmpty) {
      await deleteAllUserContext();
      userAccount.sessionRenewalRequired = true;
      return userAccount;
    }
    var request = http.Request(
        'get', Uri.parse('${BaseConfig.baseUrl}api/LoggedInUserInfo'));

    var headers = {'Authorization': "Bearer ${localStoredModel.token}"};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    userAccount.alert = response.statusCode.toString();
    if (response.statusCode == 200) {
      hideLoader();
      Map<String, dynamic> jsondata = Map<String, dynamic>.from(
          json.decode(await response.stream.bytesToString()));

      userAccount = UserAccount.fromJson(jsondata);
      localStoredModel.fcmtoken = userAccount.fcmtoken;
      localStoredModel.appUserHash = userAccount.appUserHash;
      localStoredModel.appUserId = userAccount.appUserId;
      localStoredModel.email = userAccount.email;
      localStoredModel.fullName = userAccount.fullName;
      localStoredModel.mobile = userAccount.mobile;
      localStoredModel.profileImage = userAccount.profileImage;
      localStoredModel.profileURL = userAccount.profileURL;
      localStoredModel.remoteUId = userAccount.remoteUId;
      localStoredModel.userName = userAccount.userName;
      localStoredModel.userType = userAccount.userType;
    }
    return userAccount;
  } catch (e) {
    return Exception(userAccount.alert.toString());
  }
}

Future<String?> webLogin() async {
  try {
    showLoader();
    var token = "";
    var webkey = "";
    var localStoredModel = await getUserContextData();

    if (localStoredModel.isLoggedIn == false ||
        localStoredModel.token.isEmpty) {
      await deleteAllUserContext();
      return "user not LoggedIn";
    }
    var request = http.Request(
        'get',
        Uri.parse(
            '${BaseConfig.baseUrl}api/UserWebSessionToken?DeviceInfoName=${localStoredModel.deviceId}&did=${localStoredModel.deviceId}'));
    var headers = {'Authorization': "Bearer ${localStoredModel.token}"};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      hideLoader();

      Map<String, dynamic> jsondata = Map<String, dynamic>.from(
          json.decode(await response.stream.bytesToString()));

      webkey = jsondata['webkey'] ?? '';
      if (localStoredModel.deviceId == webkey) {
        token = jsondata['webSessionHash'];
      }
    }
    return token;
  } catch (e) {
    print('Data Not Found: $e');
  }
}

showLoader() {
  BotToast.showLoading(
      backgroundColor: Colors.amber,
      backButtonBehavior:BackButtonBehavior.close,
      duration: Duration(seconds: 9500));
  BotToast.showText(text: 'Loading Data Please Wait');
}

hideLoader() {
  BotToast.closeAllLoading();
  BotToast.showText(
    backButtonBehavior: BackButtonBehavior.close,
    backgroundColor: Colors.amber,
    text: 'Loading Data Please Wait',
  );
}

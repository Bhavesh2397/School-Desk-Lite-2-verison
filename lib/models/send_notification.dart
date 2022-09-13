import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:schooldesklight/models/send_notification.dart';
import 'package:schooldesklight/models/useraccounts.dart';
import 'package:schooldesklight/utils/theme.dart';

import 'send_notification.dart';

class sendnotification {
  Student? student;

  sendnotification({this.student});

  sendnotification.fromJson(Map<String, dynamic> json) {
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    return data;
  }
}

class ClassStudents {
  String? academicClass;
  String? className;

  ClassStudents({this.academicClass, this.className});

  ClassStudents.fromJson(Map<String, dynamic> json) {
    academicClass = json['academicClass'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['academicClass'] = this.academicClass;
    data['className'] = this.className;
    return data;
  }
}

class Student {
  String? uid;
  String? school;
  String? section;
  String? gradeLevel;
  String? divisionId;
  List<ClassStudents>? classStudents;
  String? userSubscription;
  String? studentHouse;
  String? serviceType;
  String? academicTerm;

  Student(
      {this.uid,
      this.school,
      this.section,
      this.gradeLevel,
      this.divisionId,
      this.classStudents,
      this.userSubscription,
      this.studentHouse,
      this.serviceType,
      this.academicTerm});

  Student.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    school = json['school'];
    section = json['section'];
    gradeLevel = json['gradeLevel'];
    divisionId = json['divisionId'];
    if (json['classStudents'] != null) {
      classStudents = <ClassStudents>[];
      json['classStudents'].forEach((v) {
        classStudents!.add(new ClassStudents.fromJson(v));
      });
    }
    userSubscription = json['userSubscription'];
    studentHouse = json['studentHouse'];
    serviceType = json['serviceType'];
    academicTerm = json['academicTerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['school'] = this.school;
    data['section'] = this.section;
    data['gradeLevel'] = this.gradeLevel;
    data['divisionId'] = this.divisionId;
    if (this.classStudents != null) {
      data['classStudents'] =
          this.classStudents!.map((v) => v.toJson()).toList();
    }
    data['userSubscription'] = this.userSubscription;
    data['studentHouse'] = this.studentHouse;
    data['serviceType'] = this.serviceType;
    data['academicTerm'] = this.academicTerm;
    return data;
  }
}

Future<List> getnotification() async {
  showLoader();
  var url =
      Uri.parse('${BaseConfig.baseUrl}/api/UserNotificationSubscriptions');
  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOlsiVXNlciIsIlN0dWRlbnQiXSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IkRlbW8gU3R1ZGVudCAiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJjaGlyYWcucG9raXlhQHJia2VpLm9yZyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiODI5MTI1MzU3NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMTMiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3NlcmlhbG51bWJlciI6InI0NDM0MzQzMjM0MjM0MjM0MiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvYXV0aGVudGljYXRpb25tZXRob2QiOlsiTG9jYWwiLCJMb2NhbCJdLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiJTdHVkZW50IiwiUHJvZmlsZUltYWdlIjoiQjAwOSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcHJpbWFyeXNpZCI6IjEzLDQsMTAiLCJTdHVkZW50SWQiOiI0IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy91c2VyZGF0YSI6IlN0dWRlbnQiLCJleHAiOjE2OTQ1ODY5OTUsImlzcyI6IioiLCJhdWQiOiIqIn0.BM2g1Lx19a4Jbyl0NzO_kc_4A-3YUdiE8Qb9iiUP-C4";
  final response = await get(url, headers: {
    HttpHeaders.connectionHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token"
  });
  if (response.statusCode == 200) {
    hideLoader();
    Map<String, dynamic> jsondata =
        Map<String, dynamic>.from(json.decode(response.body));
        var Student = jsondata['ClassStudents'];
        return List.from(Student).map<ClassStudents>((item) => Student.fromJson(item)).toList();
  }else{
    showLoader();
    return[]; 
  }
}

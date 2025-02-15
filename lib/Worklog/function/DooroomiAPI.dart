import 'dart:convert';

import 'package:dooromi/User/model/AuthToken.dart';
import 'package:dooromi/Worklog/model/WorklogRes.dart';
import 'package:http/http.dart' as http;
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class DooroomiAPI {
  static final localHost = '10.0.2.2:7070';
  static final herokuHost = 'peaceful-mesa-17441.herokuapp.com';
  static final worklogUri = '/crane/v1/worklog';
  static final heavyEquipmentUri = '/crane/v1/heavyEquipment';


  static Future<WorklogRes> getAllWorklog(partnerName, offset) async {
    var now = DateTime.now();

    final queryParam = {
      'startedAt': now.subtract(const Duration(days: 90)).toIso8601String(),
      'finishedAt': now.add(const Duration(days: 1)).toIso8601String(),
      'partnerName' : partnerName,
      'page': offset.toString(),
      'size': '8'
    };

    final response = await http.get(
        Uri.http(herokuHost, worklogUri, queryParam),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        });

    print(" body  : " + response.body);

    return WorklogRes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static saveWorklog(Worklog worklog, BuildContext context) {
    Future<http.Response> response = fetchPost(worklog);

    response.then((value) {
      if(value.statusCode != 201) {
        print(value);
      }
        String message = value.statusCode == 201? "성공적으로 저장되었습니다." : "저장에 실패하였습니다.";

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {

                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new DooroomiNavigator()),
                            (route) => false);
                  },
                ),
              ],
          );
        });
    });
  }

  static Future<http.Response> fetchPost(Worklog worklog) async {
    return await http.post(Uri.http(herokuHost, worklogUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode(worklog.toJson()));
  }

  static deleteWorklog(Worklog worklog, BuildContext context) {
    final response = http.delete(
        Uri.http(herokuHost, worklogUri + "/" + worklog.id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        });


      response.then((value) {
        print("statuscode : " + value.statusCode.toString());

        if(value.statusCode != 200) {
          print(value);
        }

      String message = (value.statusCode == 200) ? "성공적으로 삭제되었습니다." : "삭제에 실패하였습니다.";

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => new DooroomiNavigator()),
                            (route) => false);

                  },
                ),
              ],
            );
          });
    });
  }


  static sendEmail(String from, String to, String email, BuildContext context) {

    Map<String, dynamic> json = {
      "from" : from.trim() +  "T" + "00:00:00",
      "to" : to.trim() +  "T" + "23:59:59",
      "email" :  email,
    };

    final response =  http.post(Uri.http(herokuHost, worklogUri + "/email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode(json));


    response.then((value) {
      if(value.statusCode != 200) {
        print(value);
      }

      String message = (value.statusCode == 200)
          ? "성공적으로 이메일이 발송되었습니다." : "이메일 발송에 실패하였습니다.";

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => new DooroomiNavigator()),
                            (route) => false);
                  },
                ),
              ],
            );
          });
    });
  }
}

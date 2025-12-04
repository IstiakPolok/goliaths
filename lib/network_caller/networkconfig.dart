import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services_class/shared_preferences_helper.dart';

enum RequestMethod { GET, POST, PUT, DELETE }

class NetworkConfig {
  Future ApiRequestHandler(
    RequestMethod method,
    url,
    jsonBody, {
    is_auth = false,
  }) async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    if (await InternetConnectionChecker().hasConnection) {
      var header = <String, String>{"Content-type": "application/json"};
      if (is_auth == true) {
        // Get token using SharedPreferencesHelper
        final token = await SharedPreferencesHelper.getAccessToken();
        header["Authorization"] = "JWT $token";
      }

      if (method.name == RequestMethod.GET.name) {
        try {
          var req = await http.get(Uri.parse(url), headers: header);

          print(req.statusCode);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else {
            throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.POST.name) {
        try {
          // Ensure body is a JSON string
          var bodyToSend =
              jsonBody is String ? jsonBody : json.encode(jsonBody);
          var req = await http.post(
            Uri.parse(url),
            headers: header, // <-- ensure headers are sent
            body: bodyToSend,
          );

          print('POST $url -> ${req.statusCode}');
          print(req.body);
          if (req.statusCode == 201) {
            return json.decode(req.body);
          } else if (req.statusCode == 500) {
            throw Exception("Server Error");
          } else {
            throw Exception('try again after some time');
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.PUT.name) {
        try {
          var req = await http.put(
            Uri.parse(url),
            headers: header,
            body: jsonBody,
          );

          print(req.statusCode);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else {
            throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.DELETE.name) {
        try {
          var req = await http.delete(Uri.parse(url), headers: header);

          print(req.statusCode);
          print(req);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else {
            throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please Connect Internet");
    }
  }

  ShowError(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}

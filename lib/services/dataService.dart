import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:gbv_break_the_cycle/models/dependent.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DataService {
  String baseurl = "https://break-the-cycle-test.azurewebsites.net";

  var logger = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<http.Response> postRegister(String url, Map<String, dynamic> body) async {
    url = formatter(url);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
      return response;
    
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    String token = await storage.read(key: "token");
    url = formatter(url);
    logger.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );

    return response;
  }

  Future getDependents(String url) async {
    String token = await storage.read(key: "token");
    url = formatter(url);
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i(response.body);
      return json.decode(response.body);
    }
    logger.i(response.body);
    logger.i(response.statusCode);
  }

  Future deleteDependents(String url) async {
    String token = await storage.read(key: "token");
    url = formatter(url);
    var response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i(response.body);
      return json.decode(response.body);
    }
    logger.i(response.body);
    logger.i(response.statusCode);
  }
    
  Future getUserProfile(String url) async {
    String token = await storage.read(key: "token");
    url = formatter(url);
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i(response.body);
      return json.decode(response.body);
    }
    logger.i(response.body);
    logger.i(response.statusCode);
  }

  String formatter(String url) {
    return baseurl + url;
  }
}

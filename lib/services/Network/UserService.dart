import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dutstore/main.dart';
import 'package:dutstore/models/UserProfile.dart';
import 'package:dutstore/services/Network/WebService.dart';
import 'package:dutstore/utils/Failure.dart';
import 'package:dutstore/utils/Keys.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserService {
  Future<void> signInWithEmailPassword(String email, String password);
  Future<UserProfile> getUserProfile(String uid);
  Future<void> updateInformation(String name, String email, String phone);
}

class UserService implements IUserService {
  final WebService _webservice = Get.find();
  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();

  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String> cookies = {};

  @override
  Future<bool> signInWithEmailPassword(String email, String password) async {
    FormData formData =
        FormData.fromMap({'username': email, 'password': password});
    try {
      Response response =
          await _webservice.dio.post(APIRoute.login.path, data: formData);
      cookie = response.data['data'];
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(TOKEN, response.data['data']);
      if (response.data['status_code'] != 200)
        return Future.error(Failure(response.data['error']));
      if (response.data['status'] == "success")
      return true;
      else return false;
    } on DioError catch (e, _) {
      return Future.error(e.error);
    }
  }

  @override
  Future<UserProfile> getUserProfile(String token) async {
    try {
      Response response = await _webservice.dio.get(
        APIRoute.getUserProfile.path,
          queryParameters: {'user_id': token}
      );
      return UserProfile.fromJson(response.data!['data']);
    } on DioError catch (e, _) {
      return Future.error(e.error);
    } catch (e, _) {
      return Future.error(Failure('PARSE_RESPONSE_ERROR_MESSAGE'.tr));
    }
  }

  Future<bool> registerWithEmailPassword(
      String email, String password, String name) async {
    FormData formData =
    FormData.fromMap({'username': email, 'password': password});
    try {
      Response response =
      await _webservice.dio.post(APIRoute.register.path, data: formData);

      if (response.data['status_code'] != 200)
        return Future.error(Failure(response.data['error']));
      if (response.data['status'] == "success"){
        signInWithEmailPassword(email, password);
        return true;
      }

      else return false;
    } on DioError catch (e, _) {
      return Future.error(e.error);
    }
  }

  @override
  Future<void> updateInformation(String name, String email, String phone) async{
    FormData formData =
    FormData.fromMap({
      "password": "123123",
      "email": email,
      "status": 1,
      "firstName": name,
      "lastName": name,
      "address": "Doe address",
      "phoneNumber": phone,
      "profilePicture": "no"
    });
    try {
      Response response =
          await _webservice.dio.put(APIRoute.updateProfile.path, data: formData);

      if (response.data['status_code'] != 200)
        return Future.error(Failure(response.data['error']));
    } on DioError catch (e, _) {
      return Future.error(e.error);
    }
  }
}

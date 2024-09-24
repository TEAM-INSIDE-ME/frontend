import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/mainScreen/main_page_view.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

const _storage = FlutterSecureStorage();

Future<void> saveTokens(String accessToken, String refreshToken) async {
  await _storage.write(key: 'access_token', value: accessToken);
  await _storage.write(key: 'refresh_token', value: refreshToken);
}

Future<String?> getAccesToken() async {
  return await _storage.read(key: 'access_token');
}

Future<String?> getRefreshToken() async {
  return await _storage.read(key: 'refresh_token');
}

Future<void> deleteTokens() async {
  await _storage.delete(key: 'access_token');
  await _storage.delete(key: 'refresh_toke');
}

// access token 재발급
Future<bool> refreshAccessToken() async {
  String url = '$forwardUrl/user/kakao';
  try {
    String? refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      print('refresh token 없음');
      return false;
    }
    final response = await http.post(
      Uri.parse(url),
      headers: {'refresh': refreshToken, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.headers['access'];
      final newRefreshToken = response.headers['refresh'];

      await saveTokens(newAccessToken!, newRefreshToken!);

      print('토큰 재발급 성공!');
      return true;
    } else if (response.statusCode == 401) {
      print('refresh 만료');
      deleteTokens();

      return false;
    }
  } catch (e) {
    print('Token refresh failed: $e');
  }

  return false;
}

// 카카오 유저 아이디 저장
Future<void> saveUserId(String userId) async {
  await _storage.write(key: 'user_id', value: userId);
}

// 카카오 유저 아이디 불러옴
Future<String?> getUserId() async {
  return await _storage.read(key: 'user_id');
}

Future<void> postUserInfo(BuildContext context) async {
  String? userId = await getUserId();
  String? accessToken = await getAccesToken();
  print("accessToken");
  String? refreshToken = await getRefreshToken();
  Uri url = Uri.parse('$forwardUrl/api/user/initUser')
      .replace(queryParameters: {'user_id': '$userId'});
  var userInfo = Provider.of<InfoProvider>(context, listen: false);
  print(accessToken);
  print(userId);
  try {
    print(userInfo.name);
    print(userInfo.remindTime);
    print(userInfo.password);
    print(userInfo.frequency);
    print(userInfo.gender);
    print(userInfo.birth);
    print(userInfo.job);
    print(userInfo.purpose);

    var response = await http.post(
      url,
      headers: {
        //HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "name": userInfo.name,
        "remindTime": userInfo.remindTime,
        "password": userInfo.password,
        "frequency": userInfo.frequency,
        "gender": userInfo.gender,
        "birth": userInfo.birth,
        "job": userInfo.job,
        "purpose": userInfo.purpose
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("body : ${response.body}\n");
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const MainPageView()),
      );
    } else if (response.statusCode == 401) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('error: $e');
  }
}

Future<void> saveDiaryCnt(int diaryCnt) async {
  await _storage.write(key: 'diary_cnt', value: diaryCnt.toString());
}

Future<String?> getDiaryCnt() async {
  return await _storage.read(key: 'diary_cnt');
}

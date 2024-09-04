import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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

Future<bool> refreshAccessToken() async {
  String url = 'http://localhost:8080/api/user/';
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

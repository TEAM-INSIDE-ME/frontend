import 'dart:convert'; // jsonDecode 사용
import 'package:frontend/main.dart';
import 'package:frontend/models/diary.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/utils/user_auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

class DiaryService {
  Future<List<Diary>> fetchDiaries() async {
    String? userId = await getUserId();
    userId = '3653956596'; // 임시
    final url = Uri.parse('$forwardUrl/api/diaries/getDiaries/$userId');

    // GET 요청
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // JSON 데이터를 파싱
      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = jsonDecode(responseBody);

      List<dynamic> diariesJson = data['diaries'] ?? [];

      // Diary 객체로 변환하여 리스트로 반환
      List<Diary> diaries = diariesJson.map((json) {
        // JSON 데이터를 Diary 객체로 변환
        Diary diary = Diary.fromJson(json);

        // created_at 날짜 포맷팅
        DateTime createdAtDate = DateTime.parse(diary.createdAt);
        String formattedDate = DateFormat('yyyy년 M월 d일').format(createdAtDate);

        // 포맷된 날짜를 Diary 객체에 설정
        diary.formattedDate = formattedDate;

        return diary;
      }).toList();
      saveDiaryCnt(diaries.length);
      print(diaries.length);

      return diaries;
    } else {
      throw Exception('Failed to load diaries');
    }
  }
}

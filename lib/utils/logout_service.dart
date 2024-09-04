import 'package:frontend/utils/login_platforms.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutService {
  static Future<void> signOut(LoginPlatform loginPlatform) async {
    switch (loginPlatform) {
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        print('kakao Logout');
        break;
      case LoginPlatform.naver:
        await FlutterNaverLogin.logOut();
        print('naver Logout');
        break;
      case LoginPlatform.google:
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
        print('google Logout');
        break;
      case LoginPlatform.none:
        break;
    }
  }
}

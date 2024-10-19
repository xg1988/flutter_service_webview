import 'package:flutter/material.dart';
import 'package:flutter_service02/dto/ResponseData.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_service02/home_screen.dart';
import 'package:flutter_service02/const/URLContants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Version Check',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), // 스플래시 화면 호출
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppVersion();
  }

  Future<void> _checkAppVersion() async {
    // 1. 현재 앱 버전을 가져오기
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // 2. API를 통해 서버에서 최신 버전 정보 가져오기
    try {
      String request_url = DEV_API_ROOT_PATH + DEV_API_VERSION_CHECK;
      print('request_url : ' + request_url);

      final response = await http.get(Uri.parse(DEV_API_ROOT_PATH + DEV_API_VERSION_CHECK));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        ResponseData responseData = ResponseData.fromJson(json.decode(response.body));
        String latestVersion = '';
        if (responseData.body.isNotEmpty) {
          latestVersion =  responseData.body[0].codeValue; // 첫 번째 body 요소의 codeValue
        }
        print('latestVersion : ' + latestVersion);
        print('currentVersion : ' + currentVersion);

        // 3. 버전 비교 및 분기 처리
        if (_isNewerVersion(currentVersion, latestVersion)) {
          // 업데이트가 필요할 때
          _showUpdateDialog();
        } else {
          // 최신 버전일 때 홈 화면으로 이동
          _navigateToHome();
        }
      } else {
        // API 호출 실패 시 홈 화면으로 이동
        _navigateToHome();
      }
    } catch (e) {
      // 예외 처리: 네트워크 오류 등
      _navigateToHome();
    }
  }

  bool _isNewerVersion(String current, String latest) {
    // 버전 문자열을 비교하여 최신 버전인지 확인
    List<String> currentParts = current.split('.');
    List<String> latestParts = latest.split('.');

    for (int i = 0; i < currentParts.length; i++) {
      int currentPart = int.parse(currentParts[i]);
      int latestPart = int.parse(latestParts[i]);

      if (latestPart > currentPart) return true;
      if (latestPart < currentPart) return false;
    }
    return false;
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text('A new version of the app is available. Please update to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                // 업데이트 페이지로 이동하도록 URL 열기
                Navigator.pop(context);
                // 업데이트 페이지 이동 로직 (예: 앱스토어 링크)
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome() {
    // 1. 그냥 화면 이동 일 경우
    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );*/

    // 3초 딜레이 주었을 때
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  // splash 화면 custom 설정
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash.png'), // 배경 이미지 경로
              fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 늘어나거나 잘리도록 설정
            ),
          ),
          child: Center(
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

  }
}


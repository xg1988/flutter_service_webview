import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_service02/views/webview_full_x.dart';

class HomeScreen extends StatefulWidget {
  @override
  _WebViewBottomNavState createState() => _WebViewBottomNavState();
}

class _WebViewBottomNavState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 각 탭에 맞는 웹페이지 URL을 리스트로 정의합니다.
  final List<String> _urls = [
    'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/main',      // 홈 페이지
    'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/search',    // 검색 페이지
    'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/bookmark', // 즐겨찾기 페이지
    'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/settings',  // 설정 페이지
  ];

  // WebView 컨트롤러
  WebViewController? _controller;
  bool _isLoading = true; // 로딩 상태를 관리하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공통 서비스 앱'),
        leading: IconButton(
          icon: Icon(Icons.menu), // 햄버거 메뉴 아이콘
          onPressed: () {
            // 메뉴 버튼 클릭 시 동작 정의
            print('Menu button pressed');

            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WebViewScreen(url: 'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/wholemenu', title: '전체메뉴')),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // 알림 아이콘
            onPressed: () {
              // 알림 버튼 클릭 시 동작 정의
              print('Notifications button pressed');
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WebViewScreen(url: 'https://nate.com', title: '공지사항')),
              );
            },
          ),
        ],
      ),
      body: Stack(children: [WebView(
        initialUrl: _urls[_currentIndex],
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true; // 페이지 로드 시작 시 로딩 표시
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false; // 페이지 로드 완료 시 로딩 해제
          });
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
        // 로딩 중일 때 로딩 스피너를 보여줌
        _isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox.shrink(), // 로딩이 완료되면 빈 공간을 사용하여 숨김
      ],) ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // 새로운 URL 로드
            _controller?.loadUrl(_urls[_currentIndex]);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '즐겨찾기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        selectedItemColor: Colors.blue, // 선택된 아이템의 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 색상
        type: BottomNavigationBarType.fixed, // 아이템 수가 4개 이상일 경우 사용
      ),
    );
  }
}

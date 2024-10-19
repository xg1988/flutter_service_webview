import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  WebViewScreen({required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(); // 현재 화면을 닫음
          },
        ),
      ),
      body: WebView(
        //initialUrl: 'https://flutter.dev', // 로드할 웹 페이지 URL
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted, // JavaScript 사용 설정
      ),
    );
  }
}

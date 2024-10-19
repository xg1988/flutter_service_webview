import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewTest extends StatelessWidget {
  WebviewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: 'http://ec2-3-35-217-73.ap-northeast-2.compute.amazonaws.com/main',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        )
    );
  }
}

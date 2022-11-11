import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_ios_zoom_issue/basic_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IOS WebView Issue',
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNav(
          currentIndex: 0,
        ),
        appBar: AppBar(
          title: const Text("IOS can still zoom"),
        ),
        body: const WebView(
          zoomEnabled: false,
          initialUrl: "https://example.com",
        ));
  }
}

class WebViewPageWithFix extends StatefulWidget {
  const WebViewPageWithFix({super.key});

  @override
  State<StatefulWidget> createState() => _WebViewPageWithFixState();
}

class _WebViewPageWithFixState extends State<WebViewPageWithFix> {
  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IOS can't zoom after JS runs")),
      bottomNavigationBar: const BottomNav(
        currentIndex: 1,
      ),
      body: WebView(
          zoomEnabled: false,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            setState(() {
              webViewController = controller;
            });
          },
          onPageFinished: (_) async {
            if (Platform.isIOS) {
              final jsStr = await DefaultAssetBundle.of(context)
                  .loadString("assets/ios_zoom_fix.js");
              webViewController?.runJavascript(jsStr);
            }
          },
          initialUrl: "https://example.com"),
    );
  }
}

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                  context, BasicRoute(const WebViewPage()), (_) => false);
              break;
            case 1:
              Navigator.pushAndRemoveUntil(context,
                  BasicRoute(const WebViewPageWithFix()), (route) => false);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.close), label: "Without Fix"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "With Fix")
        ]);
  }
}

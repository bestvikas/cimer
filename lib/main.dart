import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyWebView(),
    ),
  );
}

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reload,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'http://14.139.123.181:8080/EnergyMeter/usage',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });
    final controller = await _controller.future;
    await controller.reload();
  }
}

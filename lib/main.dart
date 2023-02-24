import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(webapp());

class webapp extends StatelessWidget {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
            // centerTitle: true,
            // title: Text("Veer Fitness"),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () async {
            //       if (await _controller.canGoBack()) {
            //         _controller.goBack();
            //       }
            //     },
            //   ),
            // ],
            ),
        body: WillPopScope(
          onWillPop: () async {
            if (await _controller.canGoBack()) {
              _controller.goBack();
              return false;
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Do you want to exit'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ));
              return true;
            } //else
          },
          child: WebView(
            initialUrl: 'http://14.139.123.181:8080/EnergyMeter/usage',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
        ),
      ),
    );
  }
}

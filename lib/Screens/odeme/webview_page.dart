import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import 'home_page.dart';

class WebViewPage extends StatelessWidget {
  final htmlCode;

  const WebViewPage({Key? key, this.htmlCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ödeme Sayfası'),
          backgroundColor: Colors.blue.shade900,
        ),
        body: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            var page = 'r"""$htmlCode"""';
            controller.loadString(page);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatelessWidget {
  final String url;
  final String title;

  WebView({Key key, this.url , this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      ),
    );
  }
}

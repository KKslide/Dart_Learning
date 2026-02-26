import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomRichText extends StatefulWidget {
  final String htmlContent;
  // 传入htmlStyle字符串，注入到 Html模版的style标签里面，修改富文本的样式；
  // final String htmlStyle;

  const CustomRichText({super.key, required this.htmlContent});

  @override
  State<CustomRichText> createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setVerticalScrollBarEnabled(false)
      ..loadHtmlString(getHtmlContent(widget.htmlContent));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}

  
String getHtmlContent(String htmlContent) {
  // <style>里面注入htmlStyle;
  // <script> 标签里面 或许 需要一个立即执行函数 => 手动计算Html(root标签)的fontSize, 即rem的值，方便响应式变化
  return '''
    <!DOCTYPE html>
    <html lang="en">
    <head >
      <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <script></script>
    <body>
    $htmlContent
    </body>
    <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      width: 100%;
      maxWidth: 100%;
      wordWrap: break-word;
      overflowWrap: break-word;
      whiteSpace: normal;
      margin: 0;
      padding: 0;
    }
    p {
      width: 100%;
    }
    img {
      width: 100%;
    }
    </style>
    </html>
    ''';
} 

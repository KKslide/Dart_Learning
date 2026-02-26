import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:html/dom.dart' as html;

/// 富文本中 `<pre><code>` 的代码高亮扩展. 会拦截 [pre] 标签并用 [HighlightView] 渲染, 支持换行与语法高亮.
/// 若子节点为 `<code class="language-xxx">`, 会据此使用对应语言高亮.
class PreCodeHighlightExtension extends HtmlExtension {
  const PreCodeHighlightExtension();

  @override
  Set<String> get supportedTags => {'pre'};

  /// 从 pre 下第一个 code 子元素的 class 中解析 language-xxx
  static String? _languageFromPre(html.Element preElement) {
    for (final node in preElement.nodes) {
      if (node is html.Element && node.localName == 'code') {
        for (final c in node.classes) {
          if (c.startsWith('language-')) {
            return c.substring('language-'.length);
          }
        }
        break;
      }
    }
    return null;
  }

  @override
  InlineSpan build(ExtensionContext context) {
    final element = context.element;
    final code = element?.text ?? context.innerHtml;
    final language = element != null ? _languageFromPre(element) : null;

    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(6),
        ),
        child: HighlightView(
          code,
          language: language ?? 'plaintext',
          theme: githubTheme,
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            height: 1.5,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

// 模拟 HTML 内容
// const String htmlContent = '''
//   <p> <a href=\"weixin://dl/business/?appid=&path=pages/index/index&env_version=release\" target=\"_blank\">冲向小程序</a> </p><p>超人不会飞 - 周杰伦 (Jay Chou)<br>词：周杰伦<br>曲：周杰伦<br>编曲：林迈可<br>妈妈说很多事别太计较<br>只是使命感找到了我我睡不着<br>如果说骂人要有点技巧<br>我会加点旋律你会觉得<br>超好<br>我的枪不会装弹药<br>所以放心不会有人倒<br>我拍青蜂侠不需要替身<br>因为自信是我绘画的颜料<br>我做很多事背后的意义<br>远比你们想象<br>拍个电视剧为了友情<br>与十年前的梦想<br>收视率再高也难抗衡我的伟大理想<br>因为我的人生无需再多一笔那奖项<br>我不知道何时变成了社会的那榜样<br>呵<br>被狗仔拍要对着镜头<br>要大器的模样<br>怎样<br>我唱的歌词要有点文化<br>因为随时会被当教材<br>CNN能不能等英文好一点再访<br>时代杂志封面能不能重拍<br>随时随地注意形象要控制饮食<br>不然就跟杜莎夫人蜡像的我不像<br>好莱坞的中国戏院<br>地上有很多手印脚印<br>何时才能看见我的掌<br>喔如果超人会飞<br><strong>那就让我在空中停一停歇<br>再次俯瞰这个世界<br>会让我觉得好一些<br>Oh<br>拯救地球好累<br>虽然有些疲惫但我还是会<br>不要问我哭过了没</strong><br>因为超人不能流眼泪<br>唱歌要拿最佳男歌手<br>拍电影也不能只拿个最佳新人<br>你不参加颁奖典礼就是没礼貌<br>你去参加就是代表你很在乎<br>得奖时你感动落泪<br>人家就会觉得你夸张做作<br>你没表情别人就会说太嚣张<br>如果你天生这表情<br>那些人甚至会怪你妈妈<br>结果最后是别人在得奖<br>你也要给予充分的掌声与微笑<br>开的车不能太好住的楼不能太高<br>我到底是一个创作歌手<br>还是好人好事代表<br>专辑一出就必须是冠军<br>拍了电影就必须要大卖<br>只能说当超人真的好难<br>如果超人会飞<br>那就让我在空中停一停歇<br>再次俯瞰这个世界<br>会让我觉得好一些</p><p>https://www.baidu.com/s?wd=%E5%95%8A&rsv_spt=1&rsv_iqid=0xf0e8338d00876dba&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_dl=tb&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&prefixsug=%25E5%2595%258A&rsp=4&inputT=5&rsv_sug4=5<br>Oh</p><p><br></p><p>https://www.google.com.hk/search?q=%E5%95%8A&oq=%E5%95%8A&gs_lcrp=EgZjaHJvbWUqCQgAEEUYOxiABDIJCAAQRRg7GIAEMgcIARAuGIAEMgcIAhAAGIAEMgcIAxAAGIAEMgcIBBAAGIAEMgcIBRAAGIAEMgcIBhAuGIAEMgcIBxAuGIAEMgcICBAAGIAEMgcICRAAGIAE0gEINjM1ajBqMTWoAgGwAgE&sourceid=chrome&ie=UTF-8<br>拯救地球好累</p><p><br></p><p>* . ? + \$ ^ [ ] ( ) { } | \\ /  ‘ \"\" ；&*……%￥\$#@！`~<br>虽然有些疲惫但我还是会<br>不要问我哭过了没<br>因为超人不能流眼泪</p><p><img src=\"https://cardi18ndevo.jasonanime.com/674d494355ab264b45c89a1b?e=4855182275&token=dxX6EkvGO2QtG3VBlVqoAJbA_QRYBeyz1U7Spd5z:w6-xiL-xFoJASw34Na_97as4Gc8=\" alt=\"alt\" data-href=\"href\" style=\"\"/></p><p><img src=\"https://cardi18ndevo.jasonanime.com/674d494d55ab264b45c89a1e?e=4855182285&token=dxX6EkvGO2QtG3VBlVqoAJbA_QRYBeyz1U7Spd5z:FbsWunkThupEoYU-V_hWPfGrjmU=\" alt=\"alt\" data-href=\"href\" style=\"\"/></p><p> <a href=\"https://www.google.com.hk/search?q=%E5%95%8A&oq=%E5%95%8A&gs_lcrp=EgZjaHJvbWUqCQgAEEUYOxiABDIJCAAQRRg7GIAEMgcIAhAAGIAEMgcIAxAAGIAEMgcIBBAAGIAEMgcIBRAAGIAEMgcIBhAuGIAEMgcIBxAuGIAEMgcICBAAGIAEMgcICRAAGIAE0gEINjM1ajBqMTWoAgGwAgE&sourceid=chrome&ie=UTF-8\" target=\"_blank\">跳一下</a> </p><p> <a href=\"https://www.baidu.com/s?wd=%E5%95%8A&rsv_spt=1&rsv_iqid=0x9de6d3c80019a052&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_dl=tb&rsv_enter=0&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_btype=i&prefixsug=%25E5%2595%258A&rsp=2\" target=\"_blank\">跳两下</a> </p><p> <a href=\"www.baidu.com\" target=\"_blank\">跳跳</a> <br></p><p>添加一个视频: </p><p><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<iframe src=\"//player.bilibili.com/player.html?isOutside=true&aid=115837012805941&bvid=BV1gKiEBZEHq&cid=35310928624&p=1\" scrolling=\"no\" border=\"0\" frameborder=\"no\" framespacing=\"0\" allowfullscreen=\"true\" width=\"auto\" height=\"auto\"></iframe>\n</div><p><br></p>
//   ''';

@RoutePage()
class WhateverDetailPage extends StatefulWidget {
  final String url;
  final String title;
  final String? html;

  const WhateverDetailPage({
    super.key,
    required this.url,
    required this.title,
    // this.html = htmlContent,
    this.html,
  });

  @override
  State<WhateverDetailPage> createState() => _WhateverDetailPageState();
}

class _WhateverDetailPageState extends State<WhateverDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: 1.sw,
        constraints: BoxConstraints(minHeight: 1.sh),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.white)
            ..loadRequest(Uri.parse(widget.url)),
        ),
      ),
    );
  }
}

/// 可嵌入到任意布局中的 WebView 内容（用于外层有滚动、自己按内容高度自适应的场景）
class WhateverDetailContent extends StatefulWidget {
  final String url;
  final String? html;

  const WhateverDetailContent({
    super.key,
    required this.url,
    this.html,
  });

  @override
  State<WhateverDetailContent> createState() => _WhateverDetailContentState();
}

class _WhateverDetailContentState extends State<WhateverDetailContent> {
  late final WebViewController _controller;
  double? _contentHeight; // Web 内容高度（逻辑像素）

  @override
  void initState() {
    super.initState();
    
    // 1. 初始化控制器
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // 这里可以处理 H5 内部的跳转逻辑，类似 Vue Router 的 beforeEach
            if (request.url.startsWith('weixin://')) {
              debugPrint('拦截到微信跳转: ${request.url}');
              return NavigationDecision.prevent; // 阻止 WebView 内部跳转，可以用 url_launcher 打开外部 App
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            // 页面加载完成后注入样式并测量高度，防止横向滚动并让外层按内容高度布局
            _injectStylesAndMeasure();
          },
        ),
      )
      ..addJavaScriptChannel(
        'PageHeight',
        onMessageReceived: (JavaScriptMessage message) {
          final parsed = double.tryParse(message.message);
          debugPrint('收到高度: $parsed');
          if (parsed != null && mounted) {
            setState(() {
              _contentHeight = parsed;
            });
          }
        },
      );

    // 2. 判断是加载 URL 还是加载 HTML 字符串
    _loadContent();
  }

  void _injectStylesAndMeasure() {
    _controller.runJavaScript('''
      // 1. 先注入 meta viewport 确保缩放正确
      (function() {
        var meta = document.querySelector('meta[name="viewport"]');
        if (!meta) {
          meta = document.createElement('meta');
          meta.name = 'viewport';
          document.head.appendChild(meta);
        }
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
      })();

      // 2. 注入样式，强制长内容自动换行，禁止横向滚动
      (function() {
        var style = document.createElement('style');
        style.innerHTML = `
          * {
            box-sizing: border-box;
          }
          html, body {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            max-width: 100% !important;
            overflow-x: hidden !important;
          }
          body {
            width: 100% !important;
            max-width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
            word-wrap: break-word !important;
            overflow-wrap: break-word !important;
            word-break: break-all !important;
            white-space: normal !important;
          }
          p, a, span, div {
            word-wrap: break-word !important;
            overflow-wrap: break-word !important;
            word-break: break-all !important;
            white-space: normal !important;
          }
          img, video {
            max-width: 100% !important;
            height: auto !important;
          }
          iframe {
            max-width: 100% !important;
          }
          table {
            max-width: 100% !important;
            table-layout: fixed !important;
          }
        `;
        document.head.appendChild(style);
      })();

      // 3. 等待图片加载后再测量高度
      function measureHeight() {
        // 使用多种方式获取高度,取最大值
        var heights = [
          document.body.scrollHeight,
          document.body.offsetHeight,
          document.documentElement.scrollHeight,
          document.documentElement.offsetHeight,
          document.documentElement.clientHeight
        ];
        
        var maxHeight = Math.max(...heights);
        
        // 获取设备像素比
        var dpr = window.devicePixelRatio || 1;
        
        // 发送高度(不需要乘以 dpr,webview 会自动处理)
        window.PageHeight.postMessage(String(maxHeight));
        
        console.log('测量高度:', maxHeight, 'dpr:', dpr, '所有高度:', heights);
      }

      // 等待所有图片加载完成
      function waitForImages() {
        var images = document.getElementsByTagName('img');
        var promises = [];
        
        for (var i = 0; i < images.length; i++) {
          if (!images[i].complete) {
            promises.push(new Promise(function(resolve) {
              images[i].onload = resolve;
              images[i].onerror = resolve;
            }));
          }
        }
        
        return Promise.all(promises);
      }

      // 等待 DOM 和图片都加载完成
      if (document.readyState === 'complete') {
        waitForImages().then(function() {
          measureHeight();
          // 延迟再测量几次,以防异步内容
          setTimeout(measureHeight, 100);
          setTimeout(measureHeight, 300);
          setTimeout(measureHeight, 500);
          setTimeout(measureHeight, 1000);
        });
      } else {
        window.addEventListener('load', function() {
          waitForImages().then(function() {
            measureHeight();
            setTimeout(measureHeight, 100);
            setTimeout(measureHeight, 300);
            setTimeout(measureHeight, 500);
            setTimeout(measureHeight, 1000);
          });
        });
      }
    ''');
  }

  void _loadContent() {
    if (widget.html != null && widget.html!.isNotEmpty) {
      // 加载 HTML 时包装一下,添加必要的 meta 标签
      final wrappedHtml = '''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            * { box-sizing: border-box; }
            html, body {
              margin: 0;
              padding: 0;
              width: 100%;
              max-width: 100%;
              overflow-x: hidden;
            }
            body, p, a, span, div {
              word-wrap: break-word;
              overflow-wrap: break-word;
              word-break: break-all;
              white-space: normal;
            }
            img, video {
              max-width: 100% !important;
              height: auto !important;
            }
          </style>
        </head>
        <body>
          ${widget.html}
        </body>
        </html>
      ''';
      _controller.loadHtmlString(wrappedHtml);
    } else if (widget.url.isNotEmpty) {
      _controller.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    // 默认给一个合理的初始高度，避免还未测量时为 0
    final double height = _contentHeight ?? 1.sh;

    // 3. 使用新版的 WebViewWidget，按内容高度参与外层滚动布局
    return SizedBox(
      width: 1.sw,
      height: height,
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
import 'package:flutter/material.dart';
// import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/widget/webview_page.dart';

// @RoutePage()
class StickyHeaderPage extends StatefulWidget {
  const StickyHeaderPage({super.key});

  @override
  State<StickyHeaderPage> createState() => _StickyHeaderPageState();
}

class _StickyHeaderPageState extends State<StickyHeaderPage> {
  final ScrollController _scrollController = ScrollController();
  
  late double statusBarHeight;
  late double appBarHeight;
  late double totalTopHeight;

  // AppBar 背景透明度 (0.0 完全透明, 1.0 完全不透明)
  double _appBarOpacity = 0.0;
  
  // Tabs 是否吸顶
  // bool _isTabsSticky = false;
  
  // 背景图高度
  final double _headerHeight = 200.0.w;
  
  // Tabs 的高度
  // final double _tabsHeight = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 获取滚动偏移量
    final offset = _scrollController.offset;
    
    // 计算 AppBar 背景透明度
    // 滚动距离在 0 到 headerHeight 之间时,逐渐从透明变为不透明
    final opacity = (offset / _headerHeight).clamp(0.0, 1.0);
    
    // 判断 Tabs 是否应该吸顶
    // 当滚动超过背景图高度时,Tabs 吸顶
    final isSticky = offset >= _headerHeight - totalTopHeight;
    
    setState(() {
      _appBarOpacity = opacity;
      // _isTabsSticky = isSticky;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取状态栏高度
    statusBarHeight = MediaQuery.of(context).padding.top;
    appBarHeight = 56.0;
    totalTopHeight = statusBarHeight + appBarHeight;

    // 模拟 HTML 内容
    const String htmlContent = '''
      <p> <a href=\"weixin://dl/business/?appid=&path=pages/index/index&env_version=release\" target=\"_blank\">冲向小程序</a> </p><p>超人不会飞 - 周杰伦 (Jay Chou)<br>词：周杰伦<br>曲：周杰伦<br>编曲：林迈可<br>妈妈说很多事别太计较<br>只是使命感找到了我我睡不着<br>如果说骂人要有点技巧<br>我会加点旋律你会觉得<br>超好<br>我的枪不会装弹药<br>所以放心不会有人倒<br>我拍青蜂侠不需要替身<br>因为自信是我绘画的颜料<br>我做很多事背后的意义<br>远比你们想象<br>拍个电视剧为了友情<br>与十年前的梦想<br>收视率再高也难抗衡我的伟大理想<br>因为我的人生无需再多一笔那奖项<br>我不知道何时变成了社会的那榜样<br>呵<br>被狗仔拍要对着镜头<br>要大器的模样<br>怎样<br>我唱的歌词要有点文化<br>因为随时会被当教材<br>CNN能不能等英文好一点再访<br>时代杂志封面能不能重拍<br>随时随地注意形象要控制饮食<br>不然就跟杜莎夫人蜡像的我不像<br>好莱坞的中国戏院<br>地上有很多手印脚印<br>何时才能看见我的掌<br>喔如果超人会飞<br><strong>那就让我在空中停一停歇<br>再次俯瞰这个世界<br>会让我觉得好一些<br>Oh<br>拯救地球好累<br>虽然有些疲惫但我还是会<br>不要问我哭过了没</strong><br>因为超人不能流眼泪<br>唱歌要拿最佳男歌手<br>拍电影也不能只拿个最佳新人<br>你不参加颁奖典礼就是没礼貌<br>你去参加就是代表你很在乎<br>得奖时你感动落泪<br>人家就会觉得你夸张做作<br>你没表情别人就会说太嚣张<br>如果你天生这表情<br>那些人甚至会怪你妈妈<br>结果最后是别人在得奖<br>你也要给予充分的掌声与微笑<br>开的车不能太好住的楼不能太高<br>我到底是一个创作歌手<br>还是好人好事代表<br>专辑一出就必须是冠军<br>拍了电影就必须要大卖<br>只能说当超人真的好难<br>如果超人会飞<br>那就让我在空中停一停歇<br>再次俯瞰这个世界<br>会让我觉得好一些</p><p>https://www.baidu.com/s?wd=%E5%95%8A&rsv_spt=1&rsv_iqid=0xf0e8338d00876dba&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_dl=tb&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&prefixsug=%25E5%2595%258A&rsp=4&inputT=5&rsv_sug4=5<br>Oh</p><p><br></p><p>https://www.google.com.hk/search?q=%E5%95%8A&oq=%E5%95%8A&gs_lcrp=EgZjaHJvbWUqCQgAEEUYOxiABDIJCAAQRRg7GIAEMgcIARAuGIAEMgcIAhAAGIAEMgcIAxAAGIAEMgcIBBAAGIAEMgcIBRAAGIAEMgcIBhAuGIAEMgcIBxAuGIAEMgcICBAAGIAEMgcICRAAGIAE0gEINjM1ajBqMTWoAgGwAgE&sourceid=chrome&ie=UTF-8<br>拯救地球好累</p><p><br></p><p>* . ? + \$ ^ [ ] ( ) { } | \\ /  ‘ \"\" ；&*……%￥\$#@！`~<br>虽然有些疲惫但我还是会<br>不要问我哭过了没<br>因为超人不能流眼泪</p><p><img src=\"https://cardi18ndevo.jasonanime.com/674d494355ab264b45c89a1b?e=4855182275&token=dxX6EkvGO2QtG3VBlVqoAJbA_QRYBeyz1U7Spd5z:w6-xiL-xFoJASw34Na_97as4Gc8=\" alt=\"alt\" data-href=\"href\" style=\"\"/></p><p><img src=\"https://cardi18ndevo.jasonanime.com/674d494d55ab264b45c89a1e?e=4855182285&token=dxX6EkvGO2QtG3VBlVqoAJbA_QRYBeyz1U7Spd5z:FbsWunkThupEoYU-V_hWPfGrjmU=\" alt=\"alt\" data-href=\"href\" style=\"\"/></p><p> <a href=\"https://www.google.com.hk/search?q=%E5%95%8A&oq=%E5%95%8A&gs_lcrp=EgZjaHJvbWUqCQgAEEUYOxiABDIJCAAQRRg7GIAEMgcIAhAAGIAEMgcIAxAAGIAEMgcIBBAAGIAEMgcIBRAAGIAEMgcIBhAuGIAEMgcIBxAuGIAEMgcICBAAGIAEMgcICRAAGIAE0gEINjM1ajBqMTWoAgGwAgE&sourceid=chrome&ie=UTF-8\" target=\"_blank\">跳一下</a> </p><p> <a href=\"https://www.baidu.com/s?wd=%E5%95%8A&rsv_spt=1&rsv_iqid=0x9de6d3c80019a052&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_dl=tb&rsv_enter=0&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_btype=i&prefixsug=%25E5%2595%258A&rsp=2\" target=\"_blank\">跳两下</a> </p><p> <a href=\"www.baidu.com\" target=\"_blank\">跳跳</a> <br></p><p>添加一个视频: </p><p><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<iframe src=\"//player.bilibili.com/player.html?isOutside=true&aid=115837012805941&bvid=BV1gKiEBZEHq&cid=35310928624&p=1\" scrolling=\"no\" border=\"0\" frameborder=\"no\" framespacing=\"0\" allowfullscreen=\"true\" width=\"auto\" height=\"auto\"></iframe>\n</div><p><br></p>
    ''';
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // 自定义 AppBar,背景色根据滚动动态变化
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _appBarOpacity),
            boxShadow: _appBarOpacity > 0.5
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'sticky header',
              style: TextStyle(
                color: _appBarOpacity > 0.5 ? Colors.black : Colors.white,
              ),
            ),
            iconTheme: IconThemeData(
              color: _appBarOpacity > 0.5 ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 主内容区域
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 背景图区域
              SliverToBoxAdapter(
                child: Container(
                  height: _headerHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/400/200',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    // 添加渐变遮罩,让文字更清晰
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: WhateverDetailContent(
                    url: 'https://www.baidu.com',
                    html: htmlContent,
                  ),
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

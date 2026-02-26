import 'package:flutter/widgets.dart';

class IconFont {
  static const String _family = 'IconFont';

  static const IconData home = IconData(
    0xe6e4,
    fontFamily: _family,
    matchTextDirection: true,
  );
  static const IconData blog = IconData(
    0xe669,
    fontFamily: _family,
    matchTextDirection: true,
  );
  static const IconData about = IconData(
    0xe603,
    fontFamily: _family,
    matchTextDirection: true,
  );
  static const IconData contact = IconData(
    0xe62c,
    fontFamily: _family,
    matchTextDirection: true,
  );
  
  // Social media icons (使用 kkIcon 字体族，因为这些图标在 fonts/iconfont.ttf 中)
  static const String _socialFamily = 'kkIcon';
  
  static const IconData github = IconData(
    0xe85a,
    fontFamily: _socialFamily,
    matchTextDirection: true,
  );
  static const IconData facebook = IconData(
    0xe620,
    fontFamily: _socialFamily,
    matchTextDirection: true,
  );
  static const IconData twitter = IconData(
    0xe648,
    fontFamily: _socialFamily,
    matchTextDirection: true,
  );
  static const IconData instagram = IconData(
    0xe87f,
    fontFamily: _socialFamily,
    matchTextDirection: true,
  );
  static const IconData weibo = IconData(
    0xe882,
    fontFamily: _socialFamily,
    matchTextDirection: true,
  );
}

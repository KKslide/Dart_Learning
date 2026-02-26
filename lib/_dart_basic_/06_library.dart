/*

前面介绍Dart基础知识的时候基本上都是在一个文件里面编写Dart代码的，但实际开发中不可能这么写，模块化很重要，所以这就需要使用到库的概念。

在Dart中，库的使用时通过import关键字引入的。

library指令可以创建一个库，每个Dart文件都是一个库，即使没有使用library指令来指定。


Dart中的库主要有三种：

    1、我们自定义的库     
          import 'lib/xxx.dart';
    2、系统内置库       
          import 'dart:math';    
          import 'dart:io'; 
          import 'dart:convert';
    3、Pub包管理系统中的库  
        https://pub.dev/packages
        https://pub.flutter-io.cn/packages
        https://pub.dartlang.org/flutter/

        1、需要在自己想项目根目录新建一个pubspec.yaml
        2、在pubspec.yaml文件 然后配置名称 、描述、依赖等信息
        3、然后运行 pub get 获取包下载到本地  
        4、项目中引入库 import 'package:http/http.dart' as http; 看文档使用

  注意: 如果冲突, 要用 as 关键字区分开来, 比如
    import 'package:lib1/lib1.dart';
    import 'package:lib2/lib2.dart' as lib2;

  按需导入:
    模式一：只导入需要的部分，使用show关键字，如下例子所示：
      import 'package:lib1/lib1.dart' show foo;

    模式二：隐藏不需要的部分，使用hide关键字，如下例子所示：
      import 'package:lib2/lib2.dart' hide foo;  

  懒加载, 可以减少APP的启动时间:
    import 'package:deferred/hello.dart' deferred as hello;

    当需要使用的时候，需要使用loadLibrary()方法来加载:
    greet() async {
      await hello.loadLibrary();
      hello.printGreeting();
    }

*/



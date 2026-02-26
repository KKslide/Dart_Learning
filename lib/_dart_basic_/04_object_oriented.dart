
/* 面向对象
  Dart是一门面向对象的编程语言，所有的东西都是对象，包括数字、函数等基本数据类型。

  dart的面向对象, 方式和TS也很相似...

  // class Person{
  //   String name='张三';
  //   int age=20; 
  //   //默认构造函数
  //   Person(){
  //     print('这是构造函数里面的内容  这个方法在实例化的时候触发');
  //   }
  //   void printInfo(){   
  //     print("${this.name}----${this.age}");
  //   }
  // }

  //最新版本的dart中需要初始化不可为null的实例字段，如果不初始化的话需要在属性前面加上late
  // class Person{
  //   late String name;
  //   late int age; 
  //   // 默认构造函数
  //   Person(String name,int age){
  //       this.name=name;
  //       this.age=age;
  //   }
  // // 默认构造函数的简写
  // // Person(this.name,this.age);
  //   void printInfo(){   
  //     print("${this.name}----${this.age}");
  //   }
  // }

  // dart里面构造函数可以写多个
  // dart里面, 还可以有[命名构造函数], 方便我们区分不同的构造函数
  // 构造函数可以有名字
  // 格式：类名.构造名()
  // 用于 不同初始化方式
  class A {
    // 像这样是一个命名构造函数
    A.fromJson(Map json);
  }
  class B extends A {
    B.fromJson(super.json): super.fromJson();
  }
  // dart 没有 public  private protected 这些访问修饰符
  // 但可以使用 _ 把一个属性或者方法定义成私有

  关于 static 
  静态成员属于类本身，而不是类的实例。使用 static 关键字来定义静态成员。
  静态方法不能访问非静态成员，非静态方法可以访问静态成员。

  dart 关于对象的操作符
    ?     条件运算符
    as    类型转换
    is    类型判断
    ..    级联操作 
  

  关于继承 extends 和 ES/TS 差不多
  
  // ================================
  Dart中, 类的继承
    1、子类使用extends关键词来继承父类
    2、子类会继承父类里面可见的属性和方法 但是不会继承构造函数
    3、子类能复写父类的方法 getter和setter
  
  super 关键字的使用
    1、在子类中使用super关键字来调用父类的属性和方法
    2、在子类的构造函数中使用super来调用父类的构造函数

    使用时机:
      - 子类只是 扩展 父类行为
      - 需要复用父类逻辑
      - Flutter 生命周期方法
      - 构造函数需要初始化父类状态
      - 实例化子类给父类构造函数传参

    class A {
      final int x;
      A(this.x);
    }

    class B extends A {
      // 写法1
      final int y;
      // 父类有带参构造函数（必须手动调用）
      B({required int x, this.y = 0}) : super(x);

      // 写法2
      // late int y;
      // B({required int x, y = 0}) : super(x);

      /* 
        上面两种写法的执行顺序:
          先执行 : super(name, age) (调用父类构造函数)
          再执行 {} 中的代码(构造函数体)
       */

      // 写法3, 最简写法：直接在构造函数参数列表中调用 super
      // B({required super.x, this.y = 0});
    }

  类的覆写 @override

  Dart的接口(interface), 写法也和ES/TS差不多
    dart没有interface关键字定义接口, 而是通过普通类或抽象类作为接口被实现
    同样使用implements关键字进行实现
    但是dart的接口有点奇怪, 如果实现的类是普通类, 将普通类和抽象中的属性的方法全部需要覆写一遍
    因为抽象类可以定义抽象方法, 普通类不可以, 所以一般如果要实现像Java接口那样的方式
    一般会使用抽象类
    写dart, 建议使用抽象类定义接口
    // 基础写法
    abstract class Db {
      late String uri;
      add(String data);
      save();
      delete();
    }

    class MySql implements Db {

      @override
      String uri;

      MySql(this.uri);

      @override
      add(String data) {
        print('add a data');
      }

      @override
      save() {
        return 'save successfully';
      }

      @override
      delete() {
        return null;
      }
    }

    如果要实现多个接口的话, 要用逗号分隔, 例如:
    class Branch implements BaseA, BaseB {
      // .....
    }

  Dart 也有 mixin, 和 Vue2 的 Mixin 类似, 混入一些共享功能/元素/属性/方法等
    条件和规则:
      1、作为mixins的类只能继承自Object，不能继承其他类
      2、作为mixins的类不能有构造函数
      3、一个类可以mixins多个mixins类
      4、mixins绝不是继承，也不是接口，而是一种全新的特性

    dart 里面的 mixin 使用的是 with 关键字
    mixin A {
      String aaa = 'aaa';
      printA() {
        print(aaa);
      }
    }

    mixin B {
      String bbb = 'bbb';
      printB() {
        print(bbb);
      }
    }

    class C with A,B {}

    void main() {
      var c = C(); // dart语言, 甚至都不用new...
      c.printA();
      c.printB();

      // mixins的实例类型, 就是其超类的子类型
      print(c is C);
      print(c is A);
      print(c is B);
    }
  
/* 
  factory 工厂构造函数, "工厂模式"的dart语法糖
 */
// 1. 单例模式
class Singleton {
  static final Singleton _instance = Singleton._internal();

  // 1. 私有化命名构造函数，防止外部直接实例化
  Singleton._internal();

  // 2. 工厂构造函数：调用时并不创建新对象，而是返回已有的单例
  factory Singleton() {
    return _instance;
  }
  
  void request() {
    print("Sending request...");
  }
}

// 2. 从缓存中获取对象(使用到工厂构造函数)
class Logger {
  final String name;
  static final Map<String, Logger> _cache = {};

  Logger._internal(this.name);
  
  // 工厂构造函数
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!; // 命中缓存
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger; // 存入缓存
      return logger;
    }
  }

}

// 3. 返回子类实例 (多态工厂)
abstract class Shape {
  factory Shape(String type) {
    if (type == 'circle') return Circle();
    if (type == 'square') return Square();
    throw 'Can\'t create $type';
  }
  void draw();
}

class Circle implements Shape {
  @override
  void draw() => print("Drawing Circle");
}

class Square implements Shape {
  @override
  void draw() => print("Drawing Square");
}

void main() {
  var d1 = Singleton();
  var d2 = Singleton();
  print(identical(d1, d2)); // 输出: true，证明是同一个对象

  // 虽然调用的是 Shape，但返回的是 Circle 实例
  Shape myShape = Shape('circle');
  myShape.draw();
}
  

*/

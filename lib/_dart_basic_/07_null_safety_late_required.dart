/* 空安全, 这个又和 ES/TS 很相似
  ? 可空类型
  ! 类型断言
*/
void printLength(String? str) {
  try {
    print(str?.length); // 这样写的意思是告诉 dart, str 可能为空(null), 但日子还要继续过下去
    print(str!.length); // 这样写的意思是告诉 dart, str 一定不为null, 过得了就过 过不了就算了
  } catch (e) {
    print('出错就在这里看原因: $e');
  }
}

/* late
    用于延迟初始化
*/
class Base {
  late String attr;
  late int num;
  void setSelf(String attr, int num) {
    this.attr = attr;
    this.num = num;
  }

  String printSelf() {
    // String text = '${this.attr} ||| ${this.num}'; // 以前要写this. 现在不用了
    return '$attr ||| $num';
  }
}

/* required
  最开始 @required 是注解, 现在它已经作为内置修饰符
    主要用于允许根据需要标记任何命名参数(函数或类)使得它们不为空
    因为可选参数中必须有个 required 参数或者该参数有个默认值
*/
String printSomething(String name, {int age = 18, String sex = 'male'}) {
  return 'name: $name | age: $age | gender: $sex';
}
// #1 写在 function 里, 表示一定要传入这些参数
String printDetail(String name, {required int age, required String sex, String? hobby}) {
  return 'name: $name | age: $age | gender: $sex';
}
// #2 写在 class 里, 表示一定要传入这些属性
class SomeClass {
  String attr;
  // 如果有一个问号, 表示这个属性可传可不传, 是一个可选参数
  String? other_attr;
  double num;
  SomeClass({ required this.attr, required this.num });
  void getAttr() {
    print('ATTR: $attr | NUM: $num');
  }
}

void main() {
  // ================
  Base base = Base();
  base.setSelf('some attr', 123);
  String res = base.printSelf();
  print(res);
  // ================
  String something = printSomething('name');
  String detail = printDetail('name', age: 28, sex: 'male');
  print(something);
  print(detail);
  // ================
  SomeClass theClass = SomeClass(attr: 'awful attr', num: 9527.0);
  theClass.getAttr();
}


void main(List<String> args) {
  // VariableType.the_variable();
  // StringType.the_string_type();
  // NumberType.the_num_type();
  // BoolType.the_bool_type();
  // ListType.the_list_type();
  // AboutOperator.the_operator();
  // RecordType.the_record_type();
  MapType.the_map_type();
}

late String someVar;

// 变量相关
class VariableType {
  var time = DateTime.now();
  static the_variable() {
    // var name = 'aaa';
    // name = 'bb';
    // 可以被再次赋值?
    String name = 'lyk';
    // name = 'other name';
    name += '-1105';
    print(name);

    // 空安全 ====> ? 意思是 不用的话, 编译不通过吗??
    String? firstName;

    // 延时变量 ====> late
    someVar = 'abc';
    print('延时变量 ====> $someVar');

    // final(运行时) 和 const(编译时) | 实例变量 可以是 final, 但不能是 const
    final time1 = DateTime.now();
    // const time2 = DateTime.now(); // 错误! DateTime.now() 是一个运行时函数, 在编译时无法确定

    var arr1 = const [];
    final arr2 = const [];
    const arr3 = [];

    arr1 = [123, 4]; // 这里可以重新赋值
    // arr3 = [4,5,6]; // 不可以

    // 类型检查 ====> is | 强制转换 ====> as
    const String i = '3';
    const Object j = 3;
    const arr = [(i is int) ? 1 : 2, j as int];
    const arr4 = {...arr};
    print('$arr ||| $arr4');
  }
}

// 操作符相关
class AboutOperator {
  /* 
    不懂/不熟的操作符有: 
      ?[] 条件下标访问
      ~/ 除, 返回整数结果
      is!
      ?? 空值合并
      ..
      ?..
      ...?
   */
  static the_operator() {
    var res = 5~/2;
    print('${5/2} | $res');

    var obj = { 'a': fn1, 'b': fn2, 'c': '' };
    print(obj);

  }

  static fn1 () {
    print('FN1 =====');
  }
  static fn2 () {
    print('this is fn2');
  }
}

// 字符串类型
class StringType {
  static the_string_type() {
    String firstName = 'Bruce';
    String lastName = 'Wayne';
    // String Batman = '${firstName} $lastName __ ${DateTime.now()}';
    // String Batman = '${firstName + ' ' + lastName}';
    String Batman = '$firstName  $lastName';
    print(Batman);
  }
}

// 数字类型
class NumberType {
  static the_num_type() {
    int num1 = 100; // only 整型
    num num2 = 99.99; // 可整可浮
    double pi = 3.14; // 只能小数
    double someNum = 2;
    print('$someNum  $pi'); // 2.0

    print(num1 + num2); // 199.99

    // double转int
    int toInt = num2.toInt();
    print(toInt);

    // int转double
    double toDouble = num1.toDouble();
    print(toDouble);

    // num可以时int/double
    num some1 = num1;
    num some2 = num2;
    print('$some1 $some2');
  }
}

// 布尔类型
class BoolType {
  static the_bool_type() {
    bool isHandsome = true;
    print('$isHandsome');
  }
}

// 记录类型
class RecordType {
  static the_record_type () {
    // 方式1
    // var record = ('first', a: 2, b: true, 'last');
    // print(record);
    // print(record.a);

    // 方式2, 记录类型注解[定义返回类型]和[参数类型]
    // (int, int) swap((int, int) record) {
    //   var (a, b) = record;
    //   return (b, a);
    // }

    // var rec1 = (1,2);
    // print(swap(rec1));

    // 方式3
    // (String, String, int) record;
    // record = ('lyk', 'male', 26);

    // 方式4
    // ({ String name, int age, String hobby }) record;
    // record = (name: 'lyk', age: 28, hobby: 'woman');
    // print(record);

    // 多返回值, 类似于 javascript 的解构赋值
    (String name, int age) userInfo(Map<String, dynamic> json) {
      return (json['name'] as String, json['age'] as int);
    }

    final json = <String, dynamic>{
      'name':'lyk',
      'age':28,
      'hobby':'woman'
    };

    var (name, age) = userInfo(json);
    print('$name, $age');
  }
}

// List 数组
class ListType {
  static the_list_type() {
    List arr = [1, 2, 3, 4, 5];
    print('1--- $arr');
    /* 
      add(内容)
      addAll(列表)
      remove(内容)
      removeLast()
      removeRange(start, end)
     */
    arr.add(6);
    print('2--- $arr');
    arr.addAll([7, 8, 9]);
    print('3--- $arr');
    arr.remove(9);
    print('4--- $arr');
    arr.forEach(print);
    /* ******************** */
    /* 
      forEach
      every
      where
      length
      last
      first
      isEmpty
     */
  }
}

// Map 对象
class MapType {
  static the_map_type() {
    Map<String, dynamic> person = {
      'name': 'lyk',
      'age': 28,
    };
    Map<String, String> personStr = {
      'name': 'lyk',
      'age': '28',
    };
    print(person);
  }
}

// =============数据类型转换===============

  // Number与String类型之间的转换

  // Number类型转换成String类型 toString()
  // String类型转成Number类型  int.parse()
  
  /* 
    其他方法: 
    double.parse
    num.parse
    int.tryParse
    double.tryParse
    num.tryParse

   */

  // 其他类型转换成Booleans类型
  // 规则:
  // 数字类型: 0为false, 非0为true
  // 字符串类型: ''为false, 非''为true
  // 其他类型: null为false, 非null为true
  /* 
  
    isEmpty / isNotEmpty 判断String/List是否为空
    isNaN 和js一样
    
   */

// ============= final 和 const =============
  /* 
    区别: 
      final 可以开始不赋值 只能赋一次; 
      final 不仅有 const 的编译时常量的特性, 最重要的它是运行时常量，
      并且final是惰性初始化(运行时第一次使用前才初始化)
   */


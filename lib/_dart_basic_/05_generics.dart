void main() {
  // ListType.the_list_type();
  // OperatorType.the_operator_type();

  // 使用,泛型(类)
  List<String> list = [];
  // List list = List<String>.filled(3, '', growable: true);
  list.add('1');
  list.add('2');
  // list.add(2); // 不能是int
  list.add('3');
  print(list);

  // 使用,泛型(接口)
  FileCache<String> file = FileCache<String>();
  file.setByKey('[key]', '[val]');
  file.getByKey('[key]');
}

// 集合-列表-List, 就像是javascript的数组, 文档: https://api.dart.dev/dart-core/List-class.html
class ListType {
  static void the_list_type() {
    // const arr = [1,23,4,5];
    // arr.forEach(print);

    // const arr = List<int>;
    // arr.add(1);
  }
}

// 集合-集合-Set, 文档: https://api.dart.dev/dart-core/Set-class.html
class SetType {}

// 集合-映射-Map, 文档: https://api.dart.dev/dart-core/Map-class.html
class MapType {}

// 展开运算符 (...) 和 空感知展开运算符 (...?)
class OperatorType {
  static void the_operator_type() {
    // var arr1 = [1,2,3];
    // var arr2 = [...arr1, 4];
    // print(arr2);

    // List<num>? arr;
    // var arr2 = [...?arr, 0];

    List<dynamic> arr = [];

    Set<String> Aset; // 定义一个Set
    Map<num, dynamic> Amap; // 定义一个Map
  }
}

// 范型 |||简单类型&函数
class GenericsType {
  static void the_generics() {
    // List的范型
    List<String> arr = []; // 写法1
    // Set的范型
    Set<String> set = {}; // 写法1
    // Map的范型
    Map<String, num> map = {}; // 写法1
  }

  // 泛型-函数
  static T getData<T>(T val) {
    return val;
  }
}

// 范型 |||类
class GenericsClass<T> {
  List<T> list = <T>[]; // 这样写更完整
  void add(T val) {
    list.add(val);
  }

  List getList() {
    return list;
  }
}

/* 泛型-接口
  小练习:
    实现数据缓存的功能：有文件缓存、和内存缓存。内存缓存和文件缓存按照接口约束实现。
    1、定义一个泛型接口 约束实现它的子类必须有getByKey(key) 和 setByKey(key,value)
    2、要求setByKey的时候的value的类型和实例化子类的时候指定的类型一致

 */

abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T val);
}

class FileCache<T> implements Cache<T> {
  @override
  T getByKey(String key) {
    String text = 'yeah! I get the key!';
    return text as T;
  }

  @override
  void setByKey(String key, T val) {
    print('这里是 set by key=>>>> ( $key ||| $val )');
  }
}

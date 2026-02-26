/* dart 常用系统内置库
    ⭐⭐⭐ 必须掌握
    1. dart:core      // 自动导入，基础类型和集合
    2. dart:async     // 异步编程（Stream, Future）
    3. dart:convert   // JSON 处理
    4. dart:io        // 文件和网络（App 开发）

    ⭐⭐ 经常使用
    5. dart:math      // 数学计算和随机数
    6. dart:collection // 高级集合类型
    7. dart:typed_data // 字节数组处理

    ⭐ 偶尔使用
    8. dart:developer  // 调试工具
    9. dart:isolate    // 多线程（复杂场景）
    10. dart:html      // Web 开发专用
  
 */

// import 'dart:core'; // 这个默认会有, 不用引入
  /* 
    void main() {
      // ======= Object 类型 ========
        List<int> arr = [1,2,3,4,5];
        Map<String, Object> obj = {
          'from': 'DC', 
          'character': 'BatMan'
        };
        print(obj.toString());
        print(arr.toString());
        // runtimeType 类似于 js 里面的 typeof
        String str = 'hello world';
        print('这个是什么??? ${str.runtimeType}');

      // ======= String 类型 ========
        String the_string = ' this is a very lonnnng story,,, SHIT.http happens.. like a png.. and try to http://google.com it ';
        print('the_string.length =>>>> ${the_string.length}');
        print('the_string.isEmpty ==>>> ${the_string.isEmpty}');
        print('isNotEmpty ==>>> ${the_string.isNotEmpty}');
        print('contains ==>>> ${the_string.contains('a')}');
        print('startsWith ==>>> ${the_string.startsWith('this')}');
        print('endsWith ==>>> ${the_string.endsWith('it')}');
        print('toUpperCase ==>>> ${the_string.toUpperCase()}');
        print('toLowerCase ==>>> ${the_string.toLowerCase()}');
        print('substring ==>>> ${the_string.substring(1,4)}');
        print('replaceAll ==>>> ${the_string.replaceAll('http', 'https')}');
        print('split ==>>> ${the_string.split(',')}');
        print('trim ==>>> ${the_string.trim()}');

      // ======= int / double ========
        int x = 10;
        int x2 = -10;
        print('isEven ==>>> ${x.isEven}');
        print('isOdd ==>>> ${x.isOdd}');
        print('abs ==>>> ${x2.abs()}');

        double y = 3.141592653;
        print('round ==>>> ${y.round()}'); // 四舍五入
        print('floor ==>>> ${y.floor()}');
        print('ceil ==>>> ${y.ceil()}');
        print('toStringAsFixed ==>>> ${y.toStringAsFixed(2)}'); // 类似 js 的 toFixed

        bool is_x_int = (x.runtimeType).toString() == 'int' ;
        bool a_bool_var = 1 > 2;

        print('is_x_int $is_x_int 啊啊啊啊啊 $a_bool_var');

      // ======= List<T> ========
        List<int> a_list = [1,2,3,4,5,6,7,8,9,0];
        // 常用属性
        print('list.length ==>>>> ${a_list.length}');
        print('list.isEmpty ==>>>> ${a_list.isEmpty}');
        print('list.isNotEmpty ==>>>> ${a_list.isNotEmpty}');
        print('list.first ==>>>> ${a_list.first}');
        print('list.last ==>>>> ${a_list.last}');
        // 常用方法
        print('list.add ==>>>> ${a_list..add(4)}'); // ..链式操作符, 牛逼~
        print('list.addAll ==>>>> ${a_list..addAll([5, 6])}');

        print('list.remove ==>>>> ${a_list.remove(2)}');
        print('list.removeAt ==>>>> ${a_list.removeAt(0)}');

        print('list.contains ==>>>> ${a_list.contains(3)}');
        print('list.indexOf ==>>>> ${a_list.indexOf(3)}');

        print('list.join ==>>>> ${a_list.join(',')}');
        // 遍历
        for (var el in a_list) {
          print('查看元素 ==>>>> $el');
        }
        // 链式操作
        print('map ==>>>> ${a_list.map((e) => e * 2).toList()}');
        print('where ==>>>> ${a_list.where((e) => e > 2).toList()}');
        print('any ==>>>> ${a_list.any((e) => e > 3)}');
        print('every ==>>>> ${a_list.every((e) => e > 0)}');

      // ======= Set =======
        Set<int> a_set = {1, 2, 3};
        print('add ==>>>> ${a_set.add(4)}');
        print('remove ==>>>> ${a_set.remove(1)}');
        print('contains ==>>>> ${a_set.contains(2)}');
        print('toList ==>>>> ${a_set.toList()}');

      // ======= Map ========
        Map<String, dynamic> a_map = {
          'name': 'BatMan',
          'age': 36,
          'hobby': 'fighting bad guys',
          'lover': 'cat lady'
        };
        // 常用方法
        print('Map 常用方法');
        print('==>>>> ${a_map['name']}');
        print('==>>>> ${a_map['age'] = 20}');

        print('containsKey ==>>>> ${a_map.containsKey('name')}');
        print('containsValue ==>>>> ${a_map.containsValue(18)}');

        print('keys ==>>>> ${a_map.keys}');
        print('values ==>>>> ${a_map.values}');
        print('entries ==>>>> ${a_map.entries}');
        // 遍历
        print('遍历map');
        a_map.forEach((k, v) {
          print('$k: $v');
        });

      // ======= 常用工具函数(顶级函数) ========
        print('hello');
        int.parse('123');
        double.parse('3.14');
        '123'.toString();
        identical(123, '123'); // 是否同一对象

      // ======= 时间相关 ========
        DateTime now = DateTime.now();
        DateTime t = DateTime(2024, 1, 1);
        print('时间相关的dart:core');
        print('now.year ==>>>> ${now.year}');
        print('now.month ==>>>> ${now.month}');
        print('now.day ==>>>> ${now.day}');

        print(now.add(Duration(days: 1))); // 这个是往后加一天的意思??
        print(now.difference(t).inDays); // 牛逼, 这个表示 now 和 t 相差多少天的意思

      
    }
  */

// import 'dart:async'; // 这里不引入也可以😧
  /* 
    void main() async {
      
      // 方式1: 使用 Future.delayed 像js里面的 setTimeout
      Future.delayed(Duration(seconds: 1), () {
        print('一秒过去了');
      });

      // 方式2: 使用 async/await
      Future printSomething() async {
        return await Future.delayed(Duration(seconds: 2), () {
          print('使用 async / await');
        });
      }
      printSomething();

      // 方式3: 立即返回 Future
      Future<int> getNumber() {
        return Future.value(42);  // 类似 Promise.resolve(42)
      }
      print(getNumber());

      // 方式4: 返回错误的 Future
      // Future<int> getError() {
      //   return Future.error('出错了');  // 类似 Promise.reject('出错了')
      // }
      // print(getError());
      
      countDown(int n) async {
        String text = '时间还剩: $n秒';
        if (n >= 0) {
          print(text);
          await Future.delayed(Duration(seconds: 1), () => countDown(--n));
        }
      }

      countDown(5);
      
    }
  */

// import 'dart:convert'; // 用于处理数据编码和解码,主要包括 JSON、UTF-8、Base64 等格式转换
/* 
  class User {
    final String name;
    final int age;
    final String? email;
    User({
      required this.name,
      required this.age,
      this.email
    });

    // 从json map创建对象
    factory User.fromJson(Map<String, dynamic> json) {
      return User(
        name: json['name'] as String, 
        age: json['age'] as int,
        email: json['email'] as String?
      );
    }

    // 把 dart 对象 转换成 json
    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'age': age,
        'email': email,
      };
    }
    
    @override
    String toString() {
      return 'User(name: $name, age: $age, email: $email)';
    }
  }
  // 基础用法, 以及 JSON 与 dart的类对象 相互转换
    void main() {
      String jsonString = '{"name": "sucker", "age": 30, "isStudent": false}';
      // 这个 jsonDecode 类似于 js 里面的 JSON.parse
      Map<String, dynamic> user = jsonDecode(jsonString);
      print('Name: ${user['name']}');
      print('Age: ${user['age']}');
      print('Is Student: ${user['isStudent']}');

      // Dart 对象转 JSON 字符串
      Map<String, dynamic> other_user = {
        'name': '李四',
        'age': 30,
        'hobbies': ['读书', '旅游', '编程'],
        'address': {
          'city': '北京',
          'street': '长安街'
        }
      };
      String userObjStr = jsonEncode(other_user);
      print(userObjStr);

      String jsonArray = '''
        [
          {"id": 1, "name": "用户1"},
          {"id": 2, "name": "用户2"},
          {"id": 3, "name": "用户3"}
        ]
      ''';
      print(jsonDecode(jsonArray));

      // JSON 与 dart的类对象 相互转换
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      User the_user = User.fromJson(jsonMap);
      print(the_user);
      print(the_user.email);
      
      String encoded = jsonEncode(the_user.toJson());
      print(encoded);

    }
  // 处理列表数据
    void main() {
      String jsonArray = '''
      [
        {"name": "用户A", "age": 20},
        {"name": "用户B", "age": 25},
        {"name": "用户C", "age": 30}
      ]
      ''';
      // json数组 =>>> dart对象列表
      List<dynamic> decodedArr = jsonDecode(jsonArray);
      print('decoded array: $decodedArr');
      List<User> users = decodedArr.map((json) {
        return User.fromJson(json);
      }).toList();
      print('通过 User 类创建的 decodedArr: $decodedArr');
      // dart对象列表 =>>> json数组
      String encodedArr = jsonEncode(users.map((user) {
        return user.toJson();
      }).toList());
      print('查看encodedArr: $encodedArr');
    }
  // 嵌套对象
    class Address {
      final String city;
      final String street;
      
      Address({required this.city, required this.street});
      
      factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
          city: json['city'] as String,
          street: json['street'] as String,
        );
      }
      
      Map<String, dynamic> toJson() => {'city': city, 'street': street};
    }
    class Person {
      final String name;
      final Address address;
      final List<String> hobbies;
      
      Person({
        required this.name,
        required this.address,
        required this.hobbies,
      });
      
      factory Person.fromJson(Map<String, dynamic> json) {
        return Person(
          name: json['name'] as String,
          address: Address.fromJson(json['address']),  // 嵌套对象
          hobbies: (json['hobbies'] as List).map((e) => e as String).toList(),
        );
      }
      
      Map<String, dynamic> toJson() {
        return {
          'name': name,
          'address': address.toJson(),  // 嵌套对象转换
          'hobbies': hobbies,
        };
      }
    }
    void main() {
      String data = '''
      {
        "name": "小红",
        "address": {"city": "深圳", "street": "科技园"},
        "hobbies": ["阅读", "运动", "旅游"]
      }
      ''';
      Person person = Person.fromJson(jsonDecode(data));
      print(person.name);  // 小红
      print(person.address.city);  // 深圳
      print(person.hobbies);  // [阅读, 运动, 旅游]
    }
  // 自动生成序列化代码
    这个地方在 lib/models/user.dart 里面
  
  // UTF-8 编码/解码
    void main() {
      // 字符串 转 utf8字节
      String text = '这是什么鬼';
      List<int> bytes = utf8.encode(text);
      print('看看: $bytes');
      // utf8字节转字符串
      String decoded_str = utf8.decode(bytes);
      print('看看原文: $decoded_str');
      // 处理无效 utf8 序列
      List<int> invalidBytes = [0xff,0xfe];
      String safeDecodedStr = utf8.decode(invalidBytes, allowMalformed: true);
      print(safeDecodedStr);
    }
  
  // Base64 编码/解码
    void main() {
      // 字符串 -> Base64
      String text = 'Hello, Dart!';
      String encoded = base64.encode(utf8.encode(text));
      print(encoded);  // SGVsbG8sIERhcnQh
      
      // Base64 -> 字符串
      String decoded = utf8.decode(base64.decode(encoded));
      print(decoded);  // Hello, Dart!
      
      // URL 安全的 Base64 (用于 URL 参数)
      String urlSafe = base64Url.encode(utf8.encode(text));
      print(urlSafe);
    }
  
// import 'dart:io'; // 处理文件、目录、网络、进程等 I/O 操作
  写在 markdown 文件里面了: /Users/kangyouknowwho/My_Code/A-Q&A-about-AI/05-Dart IO 介绍和常用使用方式.md

// import 'dart:math'; // 数学相关的核心库, 提供基本数学函数、常量和随机数生成
  /* 数学常量
    void main() {
      // 圆周率 π ≈ 3.14159...
      print('PI: $pi');  // 3.141592653589793
      
      // 自然对数的底 e ≈ 2.71828...
      print('E: $e');    // 2.718281828459045
      
      // 2 的平方根 ≈ 1.41421...
      print('√2: $sqrt2');  // 1.4142135623730951
      
      // 1/2 的平方根 ≈ 0.70710...
      print('√(1/2): $sqrt1_2');  // 0.7071067811865476
      
      // 2 的自然对数 ≈ 0.69314...
      print('ln(2): $ln2');  // 0.6931471805599453
      
      // 10 的自然对数 ≈ 2.30258...
      print('ln(10): $ln10');  // 2.302585092994046
    }
  */

  // 基本数学函数
    /* 绝对值、最大值、最小值
      void basicMath() {
        // 绝对值
        print((-5).abs());      // 5
        print((-3.14).abs());   // 3.14
        
        // 最大值
        print(max(10, 20));     // 20
        print(max(-5, -10));    // -5
        print(max(3.5, 3.14));  // 3.5
        
        // 最小值
        print(min(10, 20));     // 10
        print(min(-5, -10));    // -10
        print(min(3.5, 3.14));  // 3.14
        
        // 多个数的最大/最小值
        List<int> numbers = [5, 2, 8, 1, 9, 3];
        print('最大: ${numbers.reduce(max)}');  // 9
        print('最小: ${numbers.reduce(min)}');  // 1
      }
    */

    /* 幂运算和平方根
      void powerAndRoot() {
        // 幂运算: pow(底数, 指数)
        print(pow(2, 3));       // 8.0 (2³)
        print(pow(5, 2));       // 25.0 (5²)
        print(pow(10, -2));     // 0.01 (10⁻²)
        print(pow(4, 0.5));     // 2.0 (√4)
        
        // 平方根
        print(sqrt(16));        // 4.0
        print(sqrt(2));         // 1.4142135623730951
        print(sqrt(0.25));      // 0.5
        
        // 立方根 (使用 pow)
        print(pow(27, 1/3));    // 3.0 (∛27)
        print(pow(8, 1/3));     // 2.0 (∛8)
      }
    */

    /* 指数和对数
      void expAndLog() {
        // e 的 x 次方
        print(exp(0));          // 1.0 (e⁰)
        print(exp(1));          // 2.718281828459045 (e¹ = e)
        print(exp(2));          // 7.38905609893065 (e²)
        
        // 自然对数 (以 e 为底)
        print(log(1));          // 0.0 (ln(1))
        print(log(e));          // 1.0 (ln(e))
        print(log(10));         // 2.302585092994046 (ln(10))
        
        // 其他底数的对数
        // log₁₀(100) = log(100) / log(10)
        double log10_100 = log(100) / log(10);
        print('log₁₀(100): $log10_100');  // 2.0
        
        // log₂(8) = log(8) / log(2)
        double log2_8 = log(8) / log(2);
        print('log₂(8): $log2_8');  // 3.0
      }
    */

    /* 三角函数
      void trigonometry() {
        // 角度转弧度: 弧度 = 角度 × π / 180
        double degrees = 90;
        double radians = degrees * pi / 180;
        print('90° = $radians 弧度');  // 1.5707963267948966
        
        // 正弦 sin
        print(sin(0));          // 0.0
        print(sin(pi / 6));     // 0.5 (sin 30°)
        print(sin(pi / 4));     // 0.7071067811865475 (sin 45°)
        print(sin(pi / 2));     // 1.0 (sin 90°)
        
        // 余弦 cos
        print(cos(0));          // 1.0
        print(cos(pi / 3));     // 0.5 (cos 60°)
        print(cos(pi / 2));     // 近似 0
        
        // 正切 tan
        print(tan(0));          // 0.0
        print(tan(pi / 4));     // 1.0 (tan 45°)
        
        // 反三角函数 (返回弧度)
        print(asin(0.5));       // 0.5235987755982989 (30°)
        print(acos(0.5));       // 1.0471975511965979 (60°)
        print(atan(1));         // 0.7853981633974483 (45°)
        
        // atan2(y, x) - 返回 (x, y) 的角度
        print(atan2(1, 1));     // 0.7853981633974483 (45°)
        print(atan2(1, 0));     // 1.5707963267948966 (90°)
      }
      // 角度和弧度转换工具函数
      double degreesToRadians(double degrees) => degrees * pi / 180;
      double radiansToDegrees(double radians) => radians * 180 / pi;
      void main() {
        print(degreesToRadians(90));   // 1.5707963267948966
        print(radiansToDegrees(pi));   // 180.0
      }
    */

  // 随机数
    /* 基本随机数
      void randomBasics() {
        Random random = Random();
        
        // 生成 0.0 到 1.0 之间的随机小数 (不包括 1.0)
        double randomDouble = random.nextDouble();
        print('随机小数: $randomDouble');  // 例如: 0.7234567
        
        // 生成 0 到 n-1 之间的随机整数
        int randomInt = random.nextInt(10);  // 0-9
        print('0-9 的随机数: $randomInt');
        
        int dice = random.nextInt(6) + 1;  // 1-6 (骰子)
        print('骰子点数: $dice');
        
        // 生成随机布尔值
        bool randomBool = random.nextBool();
        print('随机布尔: $randomBool');
      }
    */

    /* 指定范围的随机数
      void randomInRange() {
        Random random = Random();
        
        // 生成 min 到 max 之间的随机整数 (包括 min 和 max)
        int min = 10;
        int max = 20;
        int randomInRange = min + random.nextInt(max - min + 1);
        print('10-20 的随机数: $randomInRange');
        
        // 生成指定范围的随机小数
        double minDouble = 5.0;
        double maxDouble = 10.0;
        double randomDouble = minDouble + random.nextDouble() * (maxDouble - minDouble);
        print('5.0-10.0 的随机小数: $randomDouble');
      }
      // 封装成工具函数
      int randomInt(int min, int max) {
        return min + Random().nextInt(max - min + 1);
      }
      double randomDouble(double min, double max) {
        return min + Random().nextDouble() * (max - min);
      }
      void main() {
        print(randomInt(1, 100));      // 1-100 的随机整数
        print(randomDouble(0.0, 1.0)); // 0.0-1.0 的随机小数
      }
    */

    // ....特么的太多了, 我放在这里:
      /Users/kangyouknowwho/My_Code/A-Q&A-about-AI/06-Dart math 介绍和常用使用方式.md

// import 'dart:collection'; // 相当于是 List,Set,Map 的高级扩展方法
  // 这个也太多了, 用之前最好学习一下数据结构的 队列, 哈希表, 散列... 之类的数据结构
  // 放在: /Users/kangyouknowwho/My_Code/A-Q&A-about-AI/07-Dart collection 介绍和使用方法.md

// 其他用到再看好了...
*/
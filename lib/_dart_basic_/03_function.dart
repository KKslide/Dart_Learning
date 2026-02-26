
/* Function
  
  dart的function, 基本玩法和javascript/typescript类似

  // 可选参数
  String fn(String str, [int? num]) {
    return str + (num != null ? num.toString() : '');
  }
  fn("hello");

  // 默认参数
  String printSomeInfo(String name, [String? gender = 'male', int age = 28]) {
    String text = "姓名:$name---性别:$gender---年龄:$age";
    print(text);
    return text;
  }
  printSomeInfo("张三");

  // 命名参数
  String printSomeInfo(String name, {String? gender = 'male', int age = 28}) {
    String text = "姓名:$name---性别:$gender---年龄:$age";
    print(text);
    return text;
  }
  printSomeInfo("张三", age: 30);
  
  // ================================
  // 箭头函数, 只能写一条语句，并且语句后面没有分号(;)
  // ================================

 */

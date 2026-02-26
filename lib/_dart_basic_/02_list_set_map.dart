/* List

    常用属性：
        length          长度
        reversed        翻转
        isEmpty         是否为空
        isNotEmpty      是否不为空
    常用方法：  
        add         增加
        addAll      拼接数组
        indexOf     查找  传入具体值
        remove      删除  传入具体值
        removeAt    删除  传入索引值
        fillRange   修改   
        insert(index,value);            指定位置插入    
        insertAll(index,list)           指定位置插入List
        toList()    其他类型转换成List  
        join()      List转换成字符串
        split()     字符串转化成List
        forEach   
        map
        where
        any
        every

*/

/* Set

  //用它最主要的功能就是去除数组重复内容

  //Set是没有顺序且不能重复的集合，所以不能通过索引去获取值

  List myList=['香蕉','苹果','西瓜','香蕉','苹果','香蕉','苹果'];
  var s=new Set();
  s.addAll(myList);
  print(s);
  print(s.toList());

*/

/* Map
  映射(Maps)是无序的键值对：

    常用属性：
        keys            获取所有的key值
        values          获取所有的value值
        isEmpty         是否为空
        isNotEmpty      是否不为空
    常用方法:
        remove(key)     删除指定key的数据
        addAll({...})   合并映射  给映射内增加属性
        containsValue   查看映射内的值  返回true/false
        forEach   
        map
        where
        any
        every

  //常用属性：

    // Map person={
    //   "name":"张三",
    //   "age":20,
    //   "sex":"男"
    // };

    // print(person.keys.toList());
    // print(person.values.toList());
    // print(person.isEmpty);
    // print(person.isNotEmpty);

  //常用方法：
    Map person={
      "name":"张三",
      "age":20,
      "sex":"男"
    };

    // person.addAll({
    //   "work":['敲代码','送外卖'],
    //   "height":160
    // });
    // print(person);

    // person.remove("sex");
    // print(person);

    print(person.containsValue('张三'));
  
*/
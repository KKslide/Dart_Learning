/* 
  注解写法, 类似于 Java 的注解, 用于给程序元素添加元数据.
  注解以 @ 符号开头, 可以应用于类, 方法, 变量等.
  注解可以有参数, 也可以没有参数.
  注解通常用于代码生成, 依赖注入, 序列化等场景.
*/

void main() {
  // @Todo('是谁', '做甚')
  @Todo()
  void doSomething() {
    print('just do it');
  }

  doSomething();
}

class Todo {
  final String who;
  final String what;
  const Todo({this.who = '是谁', this.what = '做什么'});
}
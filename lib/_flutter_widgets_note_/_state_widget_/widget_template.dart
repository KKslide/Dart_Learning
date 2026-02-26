import 'package:flutter/material.dart';

// 无状态组件
class StatelessTypePage extends StatelessWidget {
  const StatelessTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('这是 StatelessWidget 的模板');
  }
}

// 有状态组件
class StatefulTypePage extends StatefulWidget {
  const StatefulTypePage({super.key});

  @override
  State<StatefulTypePage> createState() => _StatefulTypePageState();
}
// 有状态组件, 这里一定要 extends 自己 create 出来的 State
class _StatefulTypePageState extends State<StatefulTypePage> {

  @override
  Widget build(BuildContext context) {
    return Text('这是 StatefulWidget 的模板');
  }
}
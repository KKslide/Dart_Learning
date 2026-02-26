import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/providers/01_counter_provider.dart';

/* 
  为什么 ConsumerWidget 不能用 AutomaticKeepAliveClientMixin？
    AutomaticKeepAliveClientMixin 只能用在 State<T> 上
    而 ConsumerWidget 没有 State
 */
@RoutePage()
class CounterPage extends ConsumerStatefulWidget { // CounterPage
  const CounterPage({super.key});

  @override
  ConsumerState<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends ConsumerState<CounterPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // keepAlive关键点1

  @override
  Widget build(BuildContext context) {
    super.build(context); // keepAlive关键点2

    final count = ref.watch(counterProvider);
    print('CounterPage build, count: $count'); // 添加调试打印
    
    return Scaffold(
      appBar: AppBar(title: const Text('01 计数器')),
      body: Center(
        child: Column(
          children: [
            Text('Count: $count', style: TextStyle(fontSize: 16.sp)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  ref.read(counterProvider.notifier).increment();
                }, child: Text('加', style: TextStyle(fontSize: 16.sp))),
                ElevatedButton(onPressed: (){
                  ref.read(counterProvider.notifier).decrement();
                }, child: Text('减', style: TextStyle(fontSize: 16.sp))),
                ElevatedButton(onPressed: (){
                  ref.read(counterProvider.notifier).reset();
                }, child: Text('+.-', style: TextStyle(fontSize: 16.sp))),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}

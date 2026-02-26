import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* 响应数据结构
  {
    "error": false,
    "category": "Pun",
    "type": "single",
    "joke": "I bought some shoes from a drug dealer. I don't know what he laced them with, but I was tripping all day!",
    "flags": {
        "nsfw": false,
        "religious": false,
        "political": false,
        "racist": false,
        "sexist": false,
        "explicit": false
    },
    "id": 203,
    "safe": false,
    "lang": "en"
  }
  {
    error: false,
    category: Dark,
    type: twopart,
    setup: Say what you want about pedophiles...,
    delivery: But at least they drive slowly through the school zones.,
    flags: {
      nsfw: true,
      religious: false,
      political: false,
      racist: false,
      sexist: false,
      explicit: false
    },
    id: 160,
    safe: false,
    lang: en
  }
*/

class Joke {
  final String joke;
  final int id;
  final String type;
  final String category; // 建议加上，方便分类

  Joke({
    required this.joke,
    required this.id,
    required this.type,
    required this.category,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    String processedJoke = "";
    
    // 逻辑：根据 type 字段或者判断字段是否存在来组合内容
    if (json['type'] == 'twopart') {
      // 格式 1: 组合 setup 和 delivery
      processedJoke = "${json['setup']}\n\n${json['delivery']}";
    } else {
      // 格式 2: 直接取 joke，如果为 null 则给空字符串
      processedJoke = json['joke'] ?? "";
    }

    return Joke(
      // 这里的 key 取决于 JSON 里的实际字段名
      joke: processedJoke,
      id: json['id'] ?? 0,
      type: json['type'] ?? "single",
      category: json['category'] ?? "Any",
    );
  }
}

final dio = Dio();

Future<Joke> fetchRandomJoke() async {
  // Fetching a random joke from a public API
  final response = await dio.get<Map<String, Object?>>(
    'https://v2.jokeapi.dev/joke/Any',
  );

  print('响应数据: ${response.data}');

  return Joke.fromJson(response.data!);
}

final randomJokeProvider = FutureProvider<Joke>((ref) async {
  // Using the fetchRandomJoke function to get a random joke
  return fetchRandomJoke();
});

@RoutePage()
class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke Generator')),
      body: SizedBox.expand(
        // 这里一定要有一个 Consumer 组件, 作用是读取 provider 的值
        child: Consumer(
          builder: (context, ref, child) {
            // 这里是什么意思? watch 间接接调用了 fetchRandomJoke 方法?
            final joke = ref.watch(randomJokeProvider);
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: switch (joke) {
                    /* 
                      AsyncValue 是一个 Riverpod 类型，用于表示异步操作（如网络请求）的状态。
                      它包含了加载、成功和错误状态的信息。 
                      AsyncValue 在许多方面与 StreamBuilder 中使用的 AsyncSnapshot 类型相似。
                    */
                    AsyncValue(:final value?) => SelectableText(
                      value.joke,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                    ),
                    AsyncValue(:final error?) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: $error',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    AsyncValue() => const CircularProgressIndicator(),
                  },
                ),

                Positioned(
                  bottom: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      // 这里是重新执行 provider 逻辑的意思
                      ref.invalidate(randomJokeProvider);
                    },
                    child: const Text('Get another joke'),
                  ),
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
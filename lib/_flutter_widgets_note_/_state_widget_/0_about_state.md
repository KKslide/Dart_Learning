
# 一、先给结论（非常重要）

> **Widget 本身是不可变的（immutable）**
>
> * ❌ 不是 StatefulWidget “自己有状态”
> * ✅ **状态存在于 State 对象中**

一句话区分：

| 类型              | 是否可变               | 用途       |
| --------------- | ------------------ | -------- |
| StatelessWidget | ❌                  | 展示、纯 UI  |
| StatefulWidget  | Widget ❌ / State ✅ | 交互、动画、异步 |

---

# 二、无状态组件（StatelessWidget）

## 1️⃣ 概念理解（人话）

> **给我数据 → 我画 UI → 不保存任何变化**

📌 类似 Web 中的：

```js
function Component(props) {
  return <div>{props.text}</div>;
}
```

---

## 2️⃣ 最基础模板（必会）

```dart
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### 模板拆解

| 部分       | 作用                               |
| -------- | -------------------------------- |
| const 构造 | 提升性能（很重要）                        |
| build    | 描述 UI                            |
| context  | 查 Theme / MediaQuery / Navigator |

---

## 3️⃣ 带参数的常规模板（最常用）

```dart
class TitleText extends StatelessWidget {
  final String title;

  const TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
```

📌 特点：

* 所有字段 `final`
* UI 完全由参数决定
* 可安全 `const`

---

## 4️⃣ StatelessWidget 适合的场景

✅ 列表 item
✅ 纯展示组件
✅ UI 组合组件
✅ Icon / Button 封装

❌ 表单输入
❌ 计数器
❌ 动画控制

---

# 三、有状态组件（StatefulWidget）

## 1️⃣ 概念理解（核心）

> **Widget 负责“配置”**
> **State 负责“变化”**

结构是 **两层类**：

```dart
StatefulWidget  <-- 不变
State           <-- 可变
```

---

## 2️⃣ 标准创建模板（最常见）

```dart
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### 命名规范（推荐）

* Widget：`MyPage`
* State：`_MyPageState`

---

## 3️⃣ 带状态的最小示例（计数器）

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void _increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Add'),
        ),
      ],
    );
  }
}
```

📌 **setState = 通知 Flutter 重建 UI**

---

# 四、State 的生命周期（非常重要）

## 1️⃣ 生命周期顺序

```text
createState
↓
initState        ← 初始化
↓
didChangeDependencies
↓
build            ← 可多次调用
↓
setState
↓
build
↓
dispose          ← 释放资源
```

---

## 2️⃣ 常用生命周期模板

```dart
class _DemoState extends State<Demo> {
  @override
  void initState() {
    super.initState();
    // 初始化数据 / 订阅
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 依赖 inherited widget
  }

  @override
  void dispose() {
    // controller.dispose()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

---

# 五、StatefulWidget 带参数（很容易写错）

## 正确写法（重要）

```dart
class UserCard extends StatefulWidget {
  final String name;

  const UserCard({
    super.key,
    required this.name,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late String displayName;

  @override
  void initState() {
    super.initState();
    displayName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Text(displayName);
  }
}
```

📌 重点：

* **State 通过 `widget.xxx` 访问参数**
* 不要在 State 构造函数中用参数

---

# 六、Stateless vs Stateful 使用对照表（工程级）

| 场景     | 推荐              |
| ------ | --------------- |
| 只展示数据  | StatelessWidget |
| 接口请求   | StatefulWidget  |
| Tab 切换 | StatefulWidget  |
| 动画     | StatefulWidget  |
| UI 组件库 | StatelessWidget |
| 页面容器   | StatefulWidget  |

---

# 七、常见误区（你一定会遇到）

### ❌ 误区 1：StatelessWidget 不能变化？

错 ❌
它**可以随着父组件 rebuild 而变化**，只是它**自己不存状态**。

---

### ❌ 误区 2：StatefulWidget 性能差？

错 ❌
性能取决于 **build 复杂度**，不是 State 与否。

---

### ❌ 误区 3：所有页面都要 StatefulWidget？

错 ❌
能 Stateless 就 Stateless（更简单、更安全）

---

# 八、开发中的“推荐模板”

## 页面级组件（推荐）

```dart
class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}
```

## 组件级 UI（推荐）

```dart
class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ...
  }
}
```

---

# 九、进阶理解（你已经能理解这一层了）

> **Flutter 的本质是：UI = f(state)**

* StatelessWidget：`UI = f(props)`
* StatefulWidget：`UI = f(state + props)`

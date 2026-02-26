
### 一句话定义

> **CustomScrollView = 一个可以自由组合 Sliver 的滚动容器**

而：

* `ListView` = `CustomScrollView + SliverList`
* `GridView` = `CustomScrollView + SliverGrid`

Flutter 只是帮你封装好了而已。

---

## Sliver 是什么？

> **Sliver = Scrollable 的“子结构块”**

它不是 Widget，而是**参与滚动布局的 Render 对象**。

常见 Sliver：

| Sliver                 | 作用                 |
| ---------------------- | ------------------ |
| SliverAppBar           | 可滚动 AppBar         |
| SliverList             | 列表                 |
| SliverGrid             | 网格                 |
| SliverToBoxAdapter     | 普通 Widget 转 Sliver |
| SliverPersistentHeader | 吸顶                 |

---

# 二、Level 1：最简单的 CustomScrollView（替代 ListView）

## 示例 1：CustomScrollView + SliverList

```dart
CustomScrollView(
  slivers: [
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('Item $index'));
        },
        childCount: 30,
      ),
    ),
  ],
);
```

### 对应关系

```dart
ListView.builder(...)
↓ 等价于
CustomScrollView + SliverList
```

📌 **什么时候这样写？**

* 你想以后加 SliverAppBar / 吸顶
* 页面结构可能会变复杂

---

# 三、Level 2：加入 SliverAppBar（滚动联动）

## 示例 2：可滚动 AppBar

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      title: Text('Title'),
      floating: true,
      snap: true,
    ),

    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item $index')),
        childCount: 30,
      ),
    ),
  ],
);
```

---

## SliverAppBar 核心参数（必须会）

| 参数             | 含义                |
| -------------- | ----------------- |
| pinned         | 是否吸顶              |
| floating       | 向下滚动立即显示          |
| snap           | floating 时是否有吸附动画 |
| expandedHeight | 展开高度              |
| flexibleSpace  | 折叠内容              |

### 行为组合速查表

| pinned | floating | 行为      |
| ------ | -------- | ------- |
| false  | false    | 普通滚动    |
| true   | false    | 吸顶      |
| false  | true     | 下拉即出现   |
| true   | true     | 吸顶 + 浮动 |

---

# 四、Level 3：SliverToBoxAdapter（桥梁）

> **普通 Widget 不能直接放进 CustomScrollView**

❌ 错误：

```dart
CustomScrollView(
  slivers: [
    Container(height: 100), // ❌
  ],
);
```

✅ 正确：

```dart
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(
      child: Container(
        height: 100,
        color: Colors.red,
      ),
    ),
  ],
);
```

---

## 示例 3：混合布局

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text('Demo')),

    SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('普通内容'),
      ),
    ),

    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => ListTile(title: Text('Item $i')),
        childCount: 20,
      ),
    ),
  ],
);
```

📌 **这是实际项目中最常见结构之一**

---

# 五、Level 4：SliverGrid（复杂内容）

## 示例 4：列表 + 网格混合

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text('Mixed')),

    SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: Colors.blue[(index % 9 + 1) * 100],
          );
        },
        childCount: 12,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    ),

    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => ListTile(title: Text('List $i')),
        childCount: 10,
      ),
    ),
  ],
);
```

📌 这在首页、电商、内容聚合页非常常见。

---

# 六、Level 5：吸顶（SliverPersistentHeader）

这是 **你之前提到“tabs 吸顶”** 的标准解法。

---

## 1️⃣ 定义 Header Delegate

```dart
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  StickyHeaderDelegate({
    required this.height,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
```

---

## 2️⃣ 使用吸顶 Header

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Profile'),
      ),
    ),

    SliverPersistentHeader(
      pinned: true,
      delegate: StickyHeaderDelegate(
        height: 48,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Text('Tabs'),
        ),
      ),
    ),

    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => ListTile(title: Text('Item $i')),
        childCount: 30,
      ),
    ),
  ],
);
```

📌 **这是：AppBar + Tabs 吸顶 的标准结构**

---

# 七、Level 6：ScrollController + CustomScrollView

```dart
final controller = ScrollController();

@override
void initState() {
  super.initState();
  controller.addListener(() {
    print(controller.offset);
  });
}
```

```dart
CustomScrollView(
  controller: controller,
  slivers: [...],
);
```

用途：

* AppBar 变色
* 滚动到某个位置
* 联动动画

---

# 八、常用配置总结（非常实用）

## CustomScrollView 常用参数

| 参数          | 说明   |
| ----------- | ---- |
| slivers     | 核心   |
| controller  | 滚动监听 |
| physics     | 滚动行为 |
| cacheExtent | 预加载  |
| reverse     | 反向滚动 |

---

## 性能建议（重要）

✅ 用 `SliverChildBuilderDelegate`
❌ 不要在 Sliver 中包 shrinkWrap ListView
❌ 不要嵌套多个 ScrollView

---

# 九、终极理解模型（建议你记住）

```
CustomScrollView
├── SliverAppBar
├── SliverToBoxAdapter
├── SliverPersistentHeader (吸顶)
├── SliverGrid
└── SliverList
```

> **所有复杂滚动页面，最终都会长这样**

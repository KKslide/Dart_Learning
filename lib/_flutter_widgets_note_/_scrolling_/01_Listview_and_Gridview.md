 **一篇系统、偏实战的 Flutter ListView / GridView 使用指南**，不是 API 罗列，而是：

> **什么时候用什么构造方式、每个参数到底解决什么问题、踩坑点在哪**

你本身已经在问「命名构造函数」这种层级的问题了，我会按 **渲染机制 + 使用场景** 来讲。

---

# 一、ListView & GridView 在 Flutter 里的本质

先定一个总认知：

> **ListView / GridView 本质都是 ScrollView + Sliver**
>
> ListView ≈ SliverList
> GridView ≈ SliverGrid

只是 Flutter **帮你封装好了**。

---

## 核心差别一句话版

| 组件       | 排列方式 | 典型场景     |
| -------- | ---- | -------- |
| ListView | 单轴线性 | 评论、消息、文章 |
| GridView | 多列网格 | 相册、商品、图标 |

---

# 二、ListView —— 常用方式 & 使用场景

## 1️⃣ ListView（默认构造）

```dart
ListView(
  children: [
    Text('A'),
    Text('B'),
    Text('C'),
  ],
)
```

### 适用场景

✔ 少量
✔ 静态
✔ 子项数量很小（< 20）

### ⚠️ 注意

* **一次性创建所有 children**
* 不适合长列表

---

## 2️⃣ ⭐️ ListView.builder（最常用）

```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ListTile(title: Text('$index'));
  },
);
```

### 适用场景

✔ 数据来自接口
✔ 列表很长
✔ 无限滚动 / 分页

### 为什么它快？

* 只构建「可视区域」item
* 滚动时复用 element

### 常用参数

| 参数          | 作用         |
| ----------- | ---------- |
| itemCount   | 数据长度       |
| itemBuilder | 懒加载构建 item |
| controller  | 监听滚动       |
| physics     | 滚动行为       |
| padding     | 内边距        |

---

## 3️⃣ ListView.separated（分割线神器）

```dart
ListView.separated(
  itemCount: 20,
  itemBuilder: (_, i) => Text('item $i'),
  separatorBuilder: (_, __) => Divider(),
);
```

### 适用场景

✔ 评论列表
✔ 聊天记录
✔ 需要固定分割 UI

📌 比 `itemBuilder` 里手写 Divider **更高效 + 更干净**

---

## 4️⃣ ListView.custom（高级用）

```dart
ListView.custom(
  childrenDelegate: SliverChildBuilderDelegate(
    (context, index) => Text('$index'),
    childCount: 100,
  ),
);
```

### 适用场景

✔ 自定义 Sliver 行为
✔ 做性能极限优化
✔ 特殊复用策略

📌 **一般业务不需要**

---

## 5️⃣ ListView.count（不太推荐）

```dart
ListView.count(
  crossAxisCount: 2,
  children: [...],
);
```

### 实际情况

* 内部其实是 **Grid**
* 官方现在更推荐 👉 `GridView.count`

---

# 三、GridView —— 常用方式 & 使用场景

## 1️⃣ GridView.count（固定列数）

```dart
GridView.count(
  crossAxisCount: 3,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  children: List.generate(
    30,
    (i) => Container(color: Colors.blue),
  ),
);
```

### 适用场景

✔ icon 网格
✔ 简单相册
✔ 菜单入口

⚠️ children 一次性创建，不适合超长列表

---

## 2️⃣ ⭐️ GridView.builder（最推荐）

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    childAspectRatio: 1,
  ),
  itemCount: 1000,
  itemBuilder: (_, index) {
    return Container(color: Colors.red);
  },
);
```

### 适用场景

✔ 商品列表
✔ 图片墙
✔ 大数据量

---

## 3️⃣ GridView.extent（固定 item 最大宽度）

```dart
GridView.extent(
  maxCrossAxisExtent: 150,
  children: [...],
);
```

### 适用场景

✔ 响应式布局
✔ 横屏 / Pad

👉 **比 count 更灵活**

---

## 4️⃣ GridView.custom（高级）

```dart
GridView.custom(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  childrenDelegate: SliverChildBuilderDelegate(
    (context, index) => Text('$index'),
    childCount: 50,
  ),
);
```

📌 用于：

* 特殊 grid 行为
* 动态 span（不规则网格）

---

# 四、ListView / GridView 通用配置（非常重要）

## 🔹 1. shrinkWrap（⚠️ 性能杀手）

```dart
ListView(
  shrinkWrap: true,
)
```

### 含义

> 让 ListView 根据内容高度自适应

### 使用场景

✔ 放在 Column / Stack 中
❌ 长列表

⚠️ 会 **测量所有子项**，性能差

---

## 🔹 2. physics（滚动行为）

```dart
physics: BouncingScrollPhysics(), // iOS
physics: ClampingScrollPhysics(), // Android
```

---

## 🔹 3. controller（监听滚动）

```dart
final controller = ScrollController();

ListView(
  controller: controller,
)
```

用于：

* 吸顶
* 滚动到指定位置
* 加载更多

---

## 🔹 4. cacheExtent（预加载）

```dart
cacheExtent: 500,
```

提高滚动流畅度（图多时有用）

---

## 🔹 5. padding vs item padding

推荐：

```dart
ListView(
  padding: EdgeInsets.zero,
)
```

把 padding 放进 item，避免首尾间距问题。

---

# 五、典型使用场景选择指南（实战）

## 🟢 场景 1：接口返回列表

👉 `ListView.builder`

---

## 🟢 场景 2：评论 + 分割线

👉 `ListView.separated`

---

## 🟢 场景 3：商品瀑布流（等宽）

👉 `GridView.builder`

---

## 🟢 场景 4：固定图标入口

👉 `GridView.count`

---

## 🟢 场景 5：ListView 嵌套在 Column

👉 `shrinkWrap: true` + `NeverScrollableScrollPhysics`

---

## 🟢 场景 6：复杂页面（吸顶 / 多区块）

👉 **CustomScrollView + SliverList / SliverGrid**

这是你前面问 AppBar / 吸顶时的终极解法。

---

# 六、常见坑总结（非常关键）

❌ ListView.builder 外层再包 SingleChildScrollView
❌ shrinkWrap + 长列表
❌ 在 itemBuilder 里 new 大对象
❌ GridView.count 用在 1000+ item

---

# 七、终极理解模型（你可以记住）

> **builder = 懒加载（推荐）**
> **children = 一次性（只用于少量）**
>
> **ListView / GridView ≈ 封装好的 Sliver**

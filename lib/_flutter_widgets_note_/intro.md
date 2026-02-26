# Flutter Widgets 分类详解

## 一、Basics（基础组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
// 容器类
Container          // 最常用的容器组件
Padding           // 内边距
Center            // 居中对齐
Align             // 自定义对齐
SizedBox          // 固定尺寸盒子

// 布局基础
Row               // 水平布局
Column            // 垂直布局
Stack             // 层叠布局
Expanded          // 弹性布局子组件
Flexible          // 灵活布局子组件

// 显示控制
Visibility        // 控制可见性
Opacity           // 透明度
```

### 需要熟悉 ⭐⭐
```dart
Scaffold          // 页面脚手架
AppBar            // 顶部导航栏
SafeArea          // 安全区域
Placeholder       // 占位符
```

### 不常用 ⭐
```dart
Baseline          // 基线对齐
Offstage          // 舞台外（隐藏但保留位置）
```

---

## 二、Layout（布局组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
// 弹性布局
Expanded          // 占据剩余空间
Flexible          // 灵活占用空间
Spacer            // 创建空白间隔

// 约束布局
ConstrainedBox    // 约束盒子
UnconstrainedBox  // 取消约束
LimitedBox        // 限制盒子
AspectRatio       // 宽高比

// 定位布局
Positioned        // Stack 中的绝对定位
IndexedStack      // 索引堆叠布局

// 包装布局
Wrap              // 自动换行布局
Flow              // 流式布局
```

### 需要熟悉 ⭐⭐
```dart
FittedBox         // 缩放适配
FractionallySizedBox  // 百分比尺寸
LayoutBuilder     // 动态布局构建器
CustomMultiChildLayout  // 自定义多子布局
Table             // 表格布局
```

### 不常用 ⭐
```dart
OverflowBox       // 溢出盒子
SliverToBoxAdapter  // Sliver 适配器
CustomSingleChildLayout  // 自定义单子布局
```

---

## 三、Text（文本组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
Text              // 基础文本
TextStyle         // 文本样式
RichText          // 富文本
TextSpan          // 文本片段
TextField         // 文本输入框
TextFormField     // 表单文本框
```

### 需要熟悉 ⭐⭐
```dart
SelectableText    // 可选择文本
DefaultTextStyle  // 默认文本样式
TextEditingController  // 文本编辑控制器
```

### 不常用 ⭐
```dart
Text.rich         // 富文本构造器
```

---

## 四、Input（输入组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
// 表单组件
TextField         // 文本输入
TextFormField     // 表单文本输入
Form              // 表单容器
FormField         // 表单字段基类

// 按钮
ElevatedButton    // 凸起按钮（主要按钮）
TextButton        // 文本按钮
OutlinedButton    // 边框按钮
IconButton        // 图标按钮
FloatingActionButton  // 悬浮按钮

// 选择器
Checkbox          // 复选框
Radio             // 单选框
Switch            // 开关
Slider            // 滑块
DropdownButton    // 下拉按钮
```

### 需要熟悉 ⭐⭐
```dart
GestureDetector   // 手势检测器
InkWell           // 水波纹点击效果
Dismissible       // 滑动删除
Draggable         // 可拖动组件
DragTarget        // 拖动目标
```

### 不常用 ⭐
```dart
RawKeyboardListener  // 键盘监听
Autocomplete      // 自动补全
ToggleButtons     // 切换按钮组
```

---

## 五、Scrolling（滚动组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
// 基础滚动
SingleChildScrollView  // 单子滚动视图
ListView              // 列表视图
ListView.builder      // 构建器列表（最常用）
ListView.separated    // 分隔符列表
GridView              // 网格视图
GridView.builder      // 构建器网格
GridView.count        // 固定数量网格

// 控制器
ScrollController      // 滚动控制器
```

### 需要熟悉 ⭐⭐
```dart
CustomScrollView  // 自定义滚动视图
NestedScrollView  // 嵌套滚动视图
PageView          // 页面视图
PageView.builder  // 构建器页面视图

// Sliver 系列
SliverAppBar      // 可折叠 AppBar
SliverList        // Sliver 列表
SliverGrid        // Sliver 网格
SliverToBoxAdapter  // Sliver 适配器

RefreshIndicator  // 下拉刷新
NotificationListener  // 滚动通知监听
Scrollbar         // 滚动条
```

### 不常用 ⭐
```dart
SliverPersistentHeader  // 固定头部
SliverFillViewport      // 填充视口
DraggableScrollableSheet  // 可拖动底部面板
ReorderableListView     // 可重排序列表
```

---

## 六、Styling（样式组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
Theme             // 主题
ThemeData         // 主题数据
BoxDecoration     // 盒子装饰
Border            // 边框
BorderRadius      // 圆角
BoxShadow         // 阴影
Gradient          // 渐变
```

### 需要熟悉 ⭐⭐
```dart
Material          // Material 设计容器
Card              // 卡片
Chip              // 标签
Divider           // 分隔线
VerticalDivider   // 垂直分隔线
DecoratedBox      // 装饰盒子
```

### 不常用 ⭐
```dart
PhysicalModel     // 物理模型
PhysicalShape     // 物理形状
ShapeDecoration   // 形状装饰
```

---

## 七、Painting（绘制组件）⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
CustomPaint       // 自定义绘制
Image             // 图片
Image.network     // 网络图片
Image.asset       // 本地图片
Icon              // 图标
CircleAvatar      // 圆形头像
```

### 需要熟悉 ⭐⭐
```dart
ClipRRect         // 圆角裁剪
ClipOval          // 椭圆裁剪
ClipRect          // 矩形裁剪
ClipPath          // 路径裁剪
BackdropFilter    // 背景滤镜
ColorFiltered     // 颜色滤镜
```

### 不常用 ⭐
```dart
CustomClipper     // 自定义裁剪器
ShaderMask        // 着色器遮罩
```

---

## 八、Animation（动画组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
AnimatedContainer // 动画容器
AnimatedOpacity   // 透明度动画
AnimatedPositioned  // 定位动画
AnimatedAlign     // 对齐动画
AnimationController  // 动画控制器
```

### 需要熟悉 ⭐⭐
```dart
Hero              // 页面切换动画
FadeTransition    // 淡入淡出
SlideTransition   // 滑动动画
ScaleTransition   // 缩放动画
RotationTransition  // 旋转动画
AnimatedBuilder   // 动画构建器
TweenAnimationBuilder  // 补间动画构建器
AnimatedCrossFade // 交叉淡入淡出
AnimatedSwitcher  // 切换动画
```

### 不常用 ⭐
```dart
DecoratedBoxTransition  // 装饰盒子动画
PositionedTransition    // 定位转换
SizeTransition         // 尺寸动画
AnimatedList           // 列表动画
AnimatedModalBarrier   // 模态屏障动画
```

---

## 九、Interaction（交互组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
GestureDetector   // 手势检测（最重要）
InkWell           // 水波纹效果
Navigator         // 页面导航
Dialog            // 对话框
showDialog()      // 显示对话框
AlertDialog       // 警告对话框
SimpleDialog      // 简单对话框
BottomSheet       // 底部弹出
showModalBottomSheet()  // 显示底部弹出
SnackBar          // 消息提示条
```

### 需要熟悉 ⭐⭐
```dart
Tooltip           // 长按提示
PopupMenuButton   // 弹出菜单
showMenu()        // 显示菜单
Drawer            // 抽屉
TabBar            // 选项卡栏
TabBarView        // 选项卡视图
BottomNavigationBar  // 底部导航栏
```

### 不常用 ⭐
```dart
LongPressDraggable  // 长按拖动
DragTarget        // 拖动目标
InteractiveViewer // 交互式查看器
Listener          // 原始指针监听
```

---

## 十、Async（异步组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
FutureBuilder     // Future 构建器（必须掌握）
StreamBuilder     // Stream 构建器（必须掌握）
```

### 需要熟悉 ⭐⭐
```dart
ValueListenableBuilder  // 值监听构建器
```

### 不常用 ⭐
```dart
AnimatedBuilder   // 动画构建器（也属于 Animation）
```

---

## 十一、Assets（资源组件）⭐⭐⭐

### 必须掌握 ⭐⭐⭐
```dart
Image.asset       // 本地图片
Image.network     // 网络图片
AssetBundle       // 资源包
DefaultAssetBundle  // 默认资源包
```

### 需要熟悉 ⭐⭐
```dart
FadeInImage      // 渐进式图片加载
CachedNetworkImage  // 缓存网络图片（第三方）
```

---

## 十二、Accessibility（无障碍）⭐

### 需要熟悉 ⭐⭐
```dart
Semantics         // 语义
ExcludeSemantics  // 排除语义
MergeSemantics    // 合并语义
```

### 不常用 ⭐
```dart
SemanticsDebugger  // 语义调试器
```

---

## 实战中最常用的 Top 30 组件

```dart
// 布局类（10个）
Container, Row, Column, Stack, Expanded
Padding, Center, Align, SizedBox, Scaffold

// 列表类（5个）
ListView.builder, GridView.builder, SingleChildScrollView
CustomScrollView, PageView

// 输入类（5个）
TextField, ElevatedButton, GestureDetector
Checkbox, Switch

// 显示类（5个）
Text, Image.network, Icon, Card, CircleAvatar

// 异步类（2个）
FutureBuilder, StreamBuilder

// 动画类（2个）
AnimatedContainer, Hero

// 导航类（1个）
Navigator
```

## 学习建议

### 第一阶段：掌握基础（1-2周）
```dart
Container, Row, Column, Text, Image
ElevatedButton, ListView, Scaffold, AppBar
```

### 第二阶段：熟悉常用（2-3周）
```dart
Stack, Expanded, GridView, TextField
GestureDetector, FutureBuilder, StreamBuilder
Navigator, Theme, CustomScrollView
```

### 第三阶段：进阶技能（1-2个月）
```dart
CustomPaint, AnimationController, Sliver系列
LayoutBuilder, InheritedWidget, Provider
自定义组件开发
```

## 重要提示

1. **优先掌握标记 ⭐⭐⭐ 的组件**，这些是日常开发 90% 都会用到的
2. **ListView.builder 和 GridView.builder** 比普通版本更高效，优先使用
3. **FutureBuilder 和 StreamBuilder** 是处理异步数据的核心
4. **GestureDetector** 是所有交互的基础
5. **Container** 是最万能的组件，但性能不如专用组件
6. 熟练掌握 **Row、Column、Stack** 三大布局，可以实现 90% 的 UI
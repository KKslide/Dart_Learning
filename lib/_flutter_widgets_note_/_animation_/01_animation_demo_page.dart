import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'dart:math';

@RoutePage()
class AnimationDemoPage extends StatelessWidget {
  const AnimationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Demo')),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _buildButton(
            context,
            'demo_1: Implicit Animation',
            ImplicitAnimation(),
          ),
          _buildButton(
            context,
            'demo_2: Animated Container',
            AnimatedContainerDemo(),
          ),
          _buildButton(
            context,
            'demo_3: Explicit Animation',
            ExlicitAnimation(),
          ),
          _buildButton(
            context,
            'demo_4: Multiple Animations',
            MultipleAnimation(),
          ),
          _buildButton(context, 'demo_5: Custom Tween', CustomTween()),
          _buildButton(context, 'demo_6: Staggered Animation', StaggeredAnimation()),
          _buildButton(context, 'demo_7: Hero Animation Version_1', HeroAnimationV1()),
          _buildButton(context, 'demo_8: Hero Animation Version_2', HeroAnimationV2()),
          _buildButton(context, 'demo_9: Physics Animation', PhysicsAnimation()),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, [Widget? page]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.orangeAccent),
          // textStyle: WidgetStatePropertyAll<TextStyle>(
          //   TextStyle(fontSize: 16, color: Colors.black87)
          // ),
        ),
        onPressed: page != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => page),
                );
              }
            : null,
        child: Text(title),
      ),
    );
  }
}

// ============================================================================
// 第 1 类: 隐式动画 - 类似 CSS transition
// ============================================================================
// CSS 对比: transition: all 0.3s ease;

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('implicit animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''
  隐式动画 = CSS transition, 
  只需要改变属性值, 动画自己就动了
  ''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),

            // AnimatedOpacity - 类似 transition: opacity 0.5s;
            AnimatedOpacity(
              opacity: _isExpanded ? 1.0 : 0.1,
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                height: 120,
                color: Colors.amber,
              ),
            ),

            SizedBox(height: 30),

            AnimatedAlign(
              alignment: _isExpanded
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'position\nanimation',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text('Do it!'),
            ),
            const SizedBox(height: 20),
            const Text(
              '常用隐式动画 Widget:\n'
              'AnimatedOpacity, AnimatedAlign, AnimatedPadding,\n'
              'AnimatedPositioned, AnimatedDefaultTextStyle',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 第 2 类: AnimatedContainer - 类似 CSS transition: all
// ============================================================================

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated container')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AnimatedContainer = CSS transition: all\n可以同时动画多个属性',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),

            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              width: _isExpanded ? 200 : 100,
              height: _isExpanded ? 200 : 100,

              // color: _isExpanded ? Colors.red : Colors.blue,
              decoration: BoxDecoration(
                color: _isExpanded ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(_isExpanded ? 0 : 50),
              ),

              child: Center(
                child: Text(
                  'THE\nCONTAINER',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text('Do it!'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 第 3 类: 显式动画基础 - 类似 CSS @keyframes
// ============================================================================
class ExlicitAnimation extends StatefulWidget {
  const ExlicitAnimation({super.key});

  @override
  State<ExlicitAnimation> createState() => _ExlicitAnimationState();
}

class _ExlicitAnimationState extends State<ExlicitAnimation>
    with SingleTickerProviderStateMixin {
  // AnimationController = 动画控制器,类似 JS 的 requestAnimationFrame
  late AnimationController _controller;

  // Animation = 动画值,类似 CSS 变量
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. 创建控制器 (设置动画时长)
    _controller = AnimationController(
      vsync: this, // 防止动画在后台运行
      duration: Duration(milliseconds: 2000),
    );
    // 2. 创建 Tween (定义动画范围: 从 0 到 300)
    _animation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explicit animation')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '显式动画 = 自己控制动画过程, 类似 CSS animation, 可以自定义动画过程, 像@keyframes 一样',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 40),

          // AnimatedBuilder - 监听动画值变化并重建 Widget
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    '宽度: ${_animation.value.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 40),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.forward();
                },
                child: Text('forward'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.reverse();
                },
                child: Text('reverse'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.stop();
                },
                child: Text('stop'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.reset();
                },
                child: Text('reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 第 4 类: 多属性动画 - 同时控制多个属性
// ============================================================================
class MultipleAnimation extends StatefulWidget {
  const MultipleAnimation({super.key});

  @override
  State<MultipleAnimation> createState() => _MultipleAnimationState();
}

class _MultipleAnimationState extends State<MultipleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 200,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multiple animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '多个动画同时运行\n类似 CSS 中同时改变 width, opacity, color',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 40),

            // 监听动画值变化并重建 Widget
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(
                        _sizeAnimation.value / 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Multiple\nAnimation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: Text('Do it!'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 第 5 类: 自定义 Tween - 动画自定义对象
// ============================================================================
class CustomTween extends StatefulWidget {
  const CustomTween({super.key});

  @override
  State<CustomTween> createState() => _CustomTweenState();
}

class _CustomTweenState extends State<CustomTween>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom tween')),
      body: Center(
        child: Column(
          children: [
            Text(
              '自定义动画类型\n类似 CSS transform: translate() rotate()',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            SlideTransition(
              position: _offsetAnimation,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.star, color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: Text('Do it!'),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================================
// 第 6 类: 交错动画 - 多个元素依次执行
// ============================================================================
class StaggeredAnimation extends StatefulWidget {
  const StaggeredAnimation({super.key});

  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
  with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    
    _animations = List.generate(
      5,
      (index) {
        double start = index * 0.1;
        double end = start + 0.6;

        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              start,
              end,
              curve: Curves.easeInOut,
            ),
          ),
        );
      }
    );
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Staggered animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '交错动画\n类似 CSS animation-delay',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -50 * _animations[index].value),
                      child: Opacity(
                        opacity: _animations[index].value,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.primaries[index % Colors.primaries.length],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            
            const SizedBox(height: 100),
            
            ElevatedButton(
              onPressed: () {
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: const Text('播放动画'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 第 7 类: Hero 动画 - 页面切换共享元素动画
// ============================================================================
class HeroAnimationV1 extends StatelessWidget {
  const HeroAnimationV1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero 动画')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hero 动画 = 共享元素转场\n类似 View Transitions API',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HeroDetailPage()),
                );
              },
              child: Hero(
                tag: 'hero-image', // 关键: 两个页面使用相同的 tag
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text('点击图片查看动画'),
          ],
        ),
      ),
    );
  }
}

class HeroAnimationV2 extends StatelessWidget {
  const HeroAnimationV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero 动画')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hero 动画 = 共享元素转场\n类似 View Transitions API',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (context, animation, secondaryAnimation) => 
                        const HeroDetailPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // 自定义曲线 - 这里使用弹性曲线
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      );
                      
                      return child;
                    },
                  ),
                );
              },
              child: Hero(
                tag: 'hero-image',
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text('点击图片查看动画'),
          ],
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情页')),
      body: Center(
        child: Hero(
          tag: 'hero-image', // 相同的 tag
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.image, size: 150, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// ============================================================================
// 第 8 类: 物理动画 - 模拟真实物理效果
// ============================================================================
class PhysicsAnimation extends StatefulWidget {
  const PhysicsAnimation({super.key});

  @override
  State<PhysicsAnimation> createState() => _PhysicsAnimationState();
}

class _PhysicsAnimationState extends State<PhysicsAnimation> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );

    // 弹簧效果
    _animation = Tween<double>(
      begin: 0,
      end: 300
    ).animate(
      CurvedAnimation(
        parent: _controller, 
        curve: Curves.elasticOut // 弹性曲线
      )
    );
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('physics?? really?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '物理动画 - 模拟真实物理效果\n类似 CSS spring() 函数',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            AnimatedBuilder(
              animation: _animation, 
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                    ),
                  ),
                );
              }
            ),
            // SizedBox(height: 40),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                _controller.reset();
                _controller.forward();
              }, 
              child: Text('Do it!')
            ),

            SizedBox(height: 40),

            const Text(
              '常用物理曲线:\n'
              'Curves.easeInOut, Curves.bounceOut,\n'
              'Curves.elasticOut, Curves.spring',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            
          ],
        ),
      ),
    );
  }
}
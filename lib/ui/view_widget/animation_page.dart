import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/ui/view_widget/hero_ex_page.dart';
import 'package:flutter_demo/ui/view_widget/implicity_anim_page.dart';
import 'package:flutter_demo/ui/view_widget/transition_anim_page.dart';

class AnimationPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _AnimationPageState();
  }

  @override
  String get tag => PageTag.AnimPage;
}

class _AnimationPageState extends BaseFlutterState<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Simple animation
            SimpleAnimEx1(),

            ///animation scale example o
            ScaleAnimEx1(),

            ///
            ScaleAnimEx2(),

            ///
            ScaleAnimEx3(),

            ///
            ScaleAnimEx4(),

            //Hero
            heroWidget(),
            //Transition Anim example
            transitionAnimWidget(),
            ///Implicitly Animation
            implicitlyAnimWidget(),
          ],
        ),
      ),
    );
  }

  ///Hero Animation example
  Widget heroWidget() {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.tealAccent[100],
      alignment: Alignment.center,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return HeroExPage();
              }));
            },
            child: Hero(
              tag: "hero_ex_tag",
              child: ClipOval(
                child: Image.asset(
                  "assets/images/my_space_medal_guide.png",
                  width: 80,
                ),
              ),
            ),
          ),
          Text("Hero Animation example.\nStagger  Animation example"),
        ],
      ),
    );
  }

  ///Transition Anim example
  Widget transitionAnimWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return TransitionAnimPage();
        }));
      },
      child: Container(
        height: 120,
        color: Colors.orange[100],
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("动画过渡组件")],
        ),
      ),
    );
  }

  ///Transition Anim example
  Widget implicitlyAnimWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return ImplicitlyAnimPage();
        }));
      },
      child: Container(
        height: 120,
        color: Colors.brown[100],
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Implicitly Animation")],
        ),
      ),
    );
  }
}

class SimpleAnimEx1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleAnimEx1State();
  }
}

class _SimpleAnimEx1State extends State<SimpleAnimEx1>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    _controller.addListener(() {
      if (mounted)
        setState(() {
          opacity = _controller?.value ?? 0;
          // print("------${_controller?.value}");
        });
    });
    //执行动画（正向动画）
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.green[100],
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Image.asset(
            "assets/images/my_space_medal_guide.png",
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}

class ScaleAnimEx1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimEx1State();
  }
}

class _ScaleAnimEx1State extends State<ScaleAnimEx1>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    //图片从0变到100
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    //执行动画（正向动画）
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.blue[100],
      child: Center(
        child: Image.asset(
          "assets/images/my_space_medal_guide.png",
          width: animation.value,
          height: animation.value,
        ),
      ),
    );
  }
}

class ScaleAnimEx2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimEx2State();
  }
}

class _ScaleAnimEx2State extends State<ScaleAnimEx2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    //图片从0变到100
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
    //执行动画（正向动画）
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.deepPurple[100],
      child: ScaleImageWidget(
        listenable: animation,
      ),
    );
  }
}

class ScaleImageWidget extends AnimatedWidget {
  final Animation<double> listenable;

  const ScaleImageWidget({Key key, this.listenable})
      : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "assets/images/my_space_medal_guide.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimEx3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimEx3State();
  }
}

class _ScaleAnimEx3State extends State<ScaleAnimEx3>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    //图片从0变到100
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
    //执行动画（正向动画）
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.brown[100],
      child: AnimatedBuilder(
        animation: animation,
        child: Image.asset(
          "assets/images/my_space_medal_guide.png",
        ),
        builder: (ctx, child) {
          return Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

///监听动画状态
///实现空间 放大-缩小-放大
class ScaleAnimEx4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimEx4State();
  }
}

class _ScaleAnimEx4State extends State<ScaleAnimEx4>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    //图片从0变到100
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.forward();
      }
    });
    //执行动画（正向动画）
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.deepPurple[100],
      child: ScaleImageWidget(
        listenable: animation,
      ),
    );
  }
}

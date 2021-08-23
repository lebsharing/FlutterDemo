import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';

class HeroExPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _HeroExPageState();
  }

  @override
  String get tag => PageTag.HeroExPage;
}

class _HeroExPageState extends BaseFlutterState<HeroExPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //在执行反向动画
      await _controller.reverse().orCancel;
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero/Stagger Animation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 140,
              child: Center(
                child: Hero(
                  tag: "hero_ex_tag",
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/my_space_medal_guide.png",
                      width: 120,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _playAnimation();
              },
              child: Container(
                height: 320,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    child: StaggerAnimation(
                      controller: _controller,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  ///下面我们看一个例子，实现一个柱状图增长的动画：
  ///开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
  ///高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
  ///
  ///
}


///https://book.flutterchina.club/chapter9/stagger_animation.html
class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    //高度动画
    height = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.6,
        curve: Curves.ease,
      ),
    ));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );

    padding = Tween(
      begin: EdgeInsets.only(left: 0.0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 1.0, curve: Curves.ease),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext ctx, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }
}

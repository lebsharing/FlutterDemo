import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/ui/view_widget/visibility_ex.dart';

///动画过渡组建实例
///https://book.flutterchina.club/chapter9/animated_widgets.html#_9-7-1-自定义动画过渡组件
class TransitionAnimPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _TransitionAnimPageState();
  }

  @override
  String get tag => PageTag.ViewWidgetExPage;
}

class _TransitionAnimPageState extends BaseFlutterState {
  var duration = Duration(seconds: 1);
  Color _decorationColor = Colors.blue;
  Color _decorationColor2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画过渡组件"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimDecorateBox1(
              decoration: BoxDecoration(
                color: _decorationColor,
              ),
              duration: duration,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = _decorationColor == Colors.red
                        ? Colors.blue
                        : Colors.red;
                  });
                },
                child: Text(
                  "AnimDecorateBox",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),


            SizedBox(height: 10,),
            ///
            AnimDecorateBox2(
              decoration: BoxDecoration(
                color: _decorationColor2,
              ),
              duration: duration,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _decorationColor2 = _decorationColor2 == Colors.red
                        ? Colors.blue
                        : Colors.red;
                  });
                },
                child: Text(
                  "AnimDecorateBox 2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimDecorateBox1 extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  AnimDecorateBox1(
      {Key key,
      @required this.decoration,
      this.child,
      this.curve = Curves.linear,
      @required this.duration,
      this.reverseDuration});

  @override
  State<StatefulWidget> createState() {
    return _AnimDecorateBox1State();
  }
}

class _AnimDecorateBox1State extends State<AnimDecorateBox1>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> _animation;

  Animation<double> get animation => _animation;

  DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: widget.duration,
        reverseDuration: widget.reverseDuration,
        vsync: this);
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: controller, curve: widget.curve);
    } else {
      _animation = controller;
    }
  }

  @override
  void didUpdateWidget(covariant AnimDecorateBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("-------didUpdateWidget---------");
    if (widget.curve != oldWidget.curve) _updateCurve();
    controller.duration = widget.duration;
    controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class AnimDecorateBox2 extends ImplicitlyAnimatedWidget {
  final BoxDecoration decoration;
  final Widget child;

  AnimDecorateBox2({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear,
    @required Duration duration,
    Duration reverseDuration,
  }) : super(key: key, curve: curve, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimDecorateBox2State();
  }
}

class _AnimDecorateBox2State
    extends ImplicitlyAnimatedWidgetState<AnimDecorateBox2> {
  DecorationTween _decorationTween;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    //在需要更新Tween时，基类会调用此方法
    _decorationTween = visitor(_decorationTween, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}

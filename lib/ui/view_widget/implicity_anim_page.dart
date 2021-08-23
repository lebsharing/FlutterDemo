import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';

///隐式动画
class ImplicitlyAnimPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _ImplicitlyAnimState();
  }

  @override
  String get tag => PageTag.ViewWidgetExPage;
}

class _ImplicitlyAnimState extends BaseFlutterState<ImplicitlyAnimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Implicity Anim"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///
              OpacityTestWidget(),

              ///
              ContainerAnimWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class OpacityTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OpacityTestState();
  }
}

class _OpacityTestState extends State<OpacityTestWidget> {
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            _opacity = Random().nextDouble();
            setState(() {
              print("***Opacity:$_opacity");
            });
          },
          child: Text("Changed Opacity"),
        ),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class ContainerAnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContainerAnimState();
  }
}

class _ContainerAnimState extends State<ContainerAnimWidget> {
  double _padding = 0.0;
  Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            _padding = randomPadding();
            _color = randomColor();
            setState(() {
              print(
                  "****Changed Container--padding:$_padding   =color:$_color");
            });
          },
          child: Text("Changed Container"),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          color: _color,
          padding: EdgeInsets.all(_padding),
          // child: Container(
          //   color: Colors.white,
          // ),
        ),
      ],
    );
  }

  double randomPadding() {
    return Random().nextDouble() * 64 + 10;
  }

  Color randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }
}

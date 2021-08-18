import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';

class VisibilityPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _VisibilityPageState();
  }

  @override
  String get tag => PageTag.ViewWidgetExPage;
}

class _VisibilityPageState extends BaseFlutterState<VisibilityPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Visibility"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Visibility Widget",
              style: titleStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  child: Text("默认显示"),
                ),
                Visibility(
                    visible: true, maintainState: true, child: Text("维持/可见")),
                Visibility(
                    visible: false, maintainState: true, child: Text("维持/不可见")),
                Visibility(visible: false, child: Text("默认不可见")),
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                    child: Container(
                      color: Colors.red,
                      width: 60,
                      height: 60,
                    )),
                Visibility(
                    visible: true,
                    maintainState: true,
                    child: Container(
                      color: Colors.orange,
                      width: 60,
                      height: 60,
                    )),
                Visibility(
                    visible: false,
                    maintainState: true,
                    child: Container(
                      color: Colors.green,
                      width: 60,
                      height: 60,
                    )),
                // Visibility(
                //     visible: false,
                //     child: Container(
                //       color: Colors.blue,
                //       width: 60,
                //       height: 60,
                //     )),
                Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      color: Colors.blue,
                      width: 60,
                      height: 60,
                    )),
                Visibility(
                    visible: true,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      color: Colors.red,
                      width: 60,
                      height: 60,
                    )),
              ],
            ),

            Text(
              "Opacity Widget",
              style: titleStyle,
            ),
            //Opacity
            Row(
              children: [
                Opacity(
                  opacity: 1,
                  child: Container(
                    color: Colors.deepPurple,
                    width: 60,
                    height: 60,
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  alwaysIncludeSemantics: true,
                  child: Container(
                    color: Colors.amber,
                    // color: Colors.deepPurple,
                    width: 60,
                    height: 60,
                  ),
                ),
                Opacity(
                  opacity: 1,
                  child: Container(
                    color: Colors.tealAccent,
                    width: 60,
                    height: 60,
                  ),
                ),
                Opacity(
                  opacity: 0,
                  alwaysIncludeSemantics: true,
                  child: Container(
                    color: Colors.red,
                    width: 60,
                    height: 60,
                  ),
                ),
                Opacity(
                  opacity: 1,
                  child: Container(
                    color: Colors.tealAccent,
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Text(
              "Offstage",
              style: titleStyle,
            ),
            Row(
              children: [
                Offstage(
                  offstage: false,
                  child: GestureDetector(
                    onTap: () {
                      print("**** on pressed 1***");
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Offstage(
                  offstage: true,
                  child: GestureDetector(
                    onTap: () {
                      print("**** on pressed 2 ***");
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.red,
                    ),
                  ),
                ),
                Offstage(
                  offstage: false,
                  child: GestureDetector(
                    onTap: () {
                      print("**** on pressed 3 ***");
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class d extends StatelessWidget {
  bool newer = false;

  @override
  Widget build(BuildContext context) {

    //TickerMode
    TickerMode;

    Widget child1 = Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
    Widget child2 = Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
    return Row(
      children: [
        if(newer)
          child2,
        newer ? child2 : child1,
      ],
    );
  }
}

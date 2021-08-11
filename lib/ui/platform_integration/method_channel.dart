import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/integration/call_native.dart';

///学习Flutter与原生之间的通信，使用Channel
///参考文章:https://zhuanlan.zhihu.com/p/82331241
///
class MethodChannelPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _MethodChannelPageState();
  }

  @override
  String get tag => PageTag.MethodChannelPage;
}

class _MethodChannelPageState extends BaseFlutterState<MethodChannelPage> {
  dynamic result;

  @override
  void initState() {
    super.initState();
    registerReceiveEvent();
  }

  void registerReceiveEvent() {
    CallNative.getEventChannel()?.receiveBroadcastStream()
        ?.listen((event) {
          print("****$event");
          result = event;
          setState(() {

          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Flutter Call Native
            Text("Method Channel"),
            OutlinedButton(
              onPressed: () async {
                result = await CallNative.getOsVersion();
                setState(() {});
              },
              child: Text("Flutter call native"),
            ),
            OutlinedButton(
              onPressed: () async {
                await CallNative.notifyNative(1);
              },
              child: Text("notify native"),
            ),
            Text.rich(
              TextSpan(
                text: "结果：",
                children: [
                  TextSpan(text: result ?? " No Result"),
                ],
              ),
            ),
            
            Container(
              height: 1,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.red
              ),
            ),
            Text("BasicMessageChannel"),
            OutlinedButton(
              onPressed: () async {
                result = await CallNative.sendMsgToNative();
                setState(() {

                });
              },
              child: Text("send msg to Native"),
            ),
            OutlinedButton(
              onPressed: () async {
                await CallNative.notifyNative(2);
              },
              child: Text("notify native send msg"),
            ),
            Text.rich(
              TextSpan(
                text: "结果：",
                children: [
                  TextSpan(text: result ?? " No Result"),
                ],
              ),
            ),

            Container(
              height: 1,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.red
              ),
            ),
            Text("-------EventChannel------"),
            OutlinedButton(
              onPressed: () async {
              },
              child: Text("send msg to Native(TODO)"),
            ),
            OutlinedButton(
              onPressed: () async {
                await CallNative.notifyNative(3);
              },
              child: Text("notify native send Event to Flutter"),
            ),
            Text.rich(
              TextSpan(
                text: "结果：",
                children: [
                  TextSpan(text: result ?? " No Result"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

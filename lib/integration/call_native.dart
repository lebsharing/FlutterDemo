import 'package:flutter/services.dart';
import 'package:flutter_demo/common/constant.dart';

class CallNative {

  static const _platform = MethodChannel(Constant.METHOD_CHANNEL);
  static const _basicPlatform = BasicMessageChannel(Constant.Basic_Msg_Channel, StandardMessageCodec());
  static const _eventPlatform = EventChannel(Constant.Event_Channel);

  static initChannel() {
    ///接受Native调用Flutter的方法
    _platform.setMethodCallHandler((call) async {
      if(call.method == "callFlutterMethod") {
        print("****Nativa Call Flutter Method****");
        return "this value from Flutter";
      }
      return true;
    });

    //添加接受处理信息的方法
    _basicPlatform.setMessageHandler((message) async {
      print("****Receive msg form Native:  $message");
      return " Reply msg send by flutter auto ${DateTime.now()}";
    });

  }

  static Future<String> getOsVersion() async {
    String result;
    try {
      result = await _platform.invokeMethod(MethodName.OS_VERSION);
    } catch(e) {
      print("****$e");
    }
    return result;
  }

  ///1: MethodChannel 2:BacisMessaageChannle 3: EventChannel
  static Future<void> notifyNative(dynamic arguments) async {
    try {
      await _platform.invokeMethod(MethodName.notifyNative,arguments);
    } catch(e) {
      print("****$e");
    }
  }

  static Future<dynamic> sendMsgToNative() async {
    return _basicPlatform.send("Send Msg to Native from Flutter");
  }

  static EventChannel getEventChannel() {
    return _eventPlatform;
  }

}

class MethodName {
  static const OS_VERSION = "getOsVersion";
  static const getValueFromFlutter = "getValueFromFlutter";
  static const notifyNative = "notifyNative";
}
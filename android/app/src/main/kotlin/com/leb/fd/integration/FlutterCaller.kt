package com.leb.fd.integration

import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec

class FlutterCaller private constructor() {
    private lateinit var methodChannel: MethodChannel;
    private lateinit var baseMsgChannel: BasicMessageChannel<Any>;
    private  lateinit var eventChannel:EventChannel;

    companion object {
        final var METHOD_CHANNEL: String = "com.leb.fc/flutter_demo";
        final val BaseMsgChannel:String = "com.leb.fd/base_msg_channel";
        final val EVENT_CHANNEL:String = "com.leb.fd/base_msg_channel";

        val mInstance: FlutterCaller by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
            FlutterCaller();
        }

        const val TAG = "flutter_caller";
    }

    fun initChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL);
        methodChannel.setMethodCallHandler(FlutterMethodHandler());

        //BasicMessageChannel
        baseMsgChannel = BasicMessageChannel(flutterEngine.dartExecutor.binaryMessenger, BaseMsgChannel,StandardMessageCodec.INSTANCE);
        baseMsgChannel.setMessageHandler(BasicFlutterMsgHandler());

        //EventChannel
        eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL);
        eventChannel.setStreamHandler(EventStreamHandler());
    }


    fun callFlutterMethod() {
        methodChannel.invokeMethod("callFlutterMethod",null,object : MethodChannel.Result{
            override fun success(result: Any?) {
                Log.e(TAG,"****callFlutterMethod success***$result");
            }

            override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                Log.e(TAG,"****callFlutterMethod error***$errorCode");

            }

            override fun notImplemented() {
                Log.e(TAG,"****callFlutterMethod notImplemented***");

            }
        })
    }

    fun sendMsgToFlutter() {
        baseMsgChannel.send("Msg from Native",object : BasicMessageChannel.Reply<Any>{
            override fun reply(reply: Any?) {
                Log.e(TAG,"after send msg to Flutter,the replay is ：$reply");
            }
        })
    }

}
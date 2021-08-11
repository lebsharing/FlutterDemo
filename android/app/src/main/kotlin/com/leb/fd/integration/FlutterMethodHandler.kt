package com.leb.fd.integration

import android.nfc.Tag
import android.util.Log
import com.leb.fd.utils.AppUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterMethodHandler : MethodChannel.MethodCallHandler {

    companion object {
        const val TAG = "method_handler";
        final const val OsVersion = "getOsVersion";
        final const val notifyNative = "notifyNative";//通知native,call flutter method
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        var name = call.method;
        when (name) {
            OsVersion -> {
                val osVersion = AppUtils.getOsVersion();
                result.success(osVersion);
            }
            notifyNative -> {
                var arguments = call.arguments;
                result.success(true);
                if (arguments is Int) {
                    if (arguments == 1) {
                        FlutterCaller.mInstance.callFlutterMethod();
                    } else if (arguments == 2) {
                        FlutterCaller.mInstance.sendMsgToFlutter();
                    } else if (arguments == 3) {

                    }
                } else {
                    Log.e(TAG, "--${call.method}  ${call.arguments}");
                }
            }
            else -> {
//                result.error("$name Not Impletion");
                result.notImplemented();
            }
        }
    }
}
package com.leb.fd.integration

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel

class BasicFlutterMsgHandler : BasicMessageChannel.MessageHandler<Any> {

    companion object {
        final const val TAG = "basic_channel";
    }
    override fun onMessage(message: Any?, reply: BasicMessageChannel.Reply<Any>) {
        Log.e(TAG,"msg from Flutter: $message");
        reply.reply("send replay when receive msg from Flutter");
    }

}
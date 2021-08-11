package com.leb.fd

import com.leb.fd.integration.FlutterCaller
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        FlutterCaller.mInstance.initChannel(flutterEngine);
    }
}

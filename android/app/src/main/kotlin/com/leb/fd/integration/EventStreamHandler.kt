package com.leb.fd.integration

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.util.Log
import com.leb.fd.common.Config
import io.flutter.plugin.common.EventChannel

class EventStreamHandler : EventChannel.StreamHandler {

    companion object {
        const val TAG: String = "event_channel";

    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        var chargingBroadcastReceiver = createChargingBroadcaseReceiver(events);
        Config.getContext()?.registerReceiver(
            chargingBroadcastReceiver,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        );
    }

    override fun onCancel(arguments: Any?) {
        Log.e(TAG, "****EventChannel Cancel***$arguments");
    }

    private fun createChargingBroadcaseReceiver(eventSink: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                var status: Int? = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
                Log.e(TAG, "****BroadcastReceiver ----onReceive  $status");
                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    eventSink?.error("UNAVALIABLE", "charging status is unavailable", null);
                } else {
                    var isCharging: Boolean = status == BatteryManager.BATTERY_STATUS_CHARGING;
                    eventSink?.success(if (isCharging) "Chargin" else "DisCharging");
                }

            }

        }
    }
}
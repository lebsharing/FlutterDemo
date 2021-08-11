package com.leb.fd.common

import android.app.Application

class FdApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        Config.setApplication(this);
    }
}
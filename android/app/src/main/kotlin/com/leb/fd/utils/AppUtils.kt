package com.leb.fd.utils

object AppUtils {

    fun getOsVersion(): String {
        return android.os.Build.VERSION.RELEASE + " - " +
                android.os.Build.VERSION.BASE_OS + " - " +
                android.os.Build.VERSION.CODENAME;
    }
}
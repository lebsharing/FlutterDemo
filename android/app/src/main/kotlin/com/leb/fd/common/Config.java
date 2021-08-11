package com.leb.fd.common;

import android.app.Application;
import android.content.Context;

public class Config {
    private static Context mContext;

    public static void setApplication(Application context) {
        mContext = context;
    }

    public static Context getContext() {
        return mContext;
    }
}

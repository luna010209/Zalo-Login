package com.example.login_zalo;

import android.app.Application;

import com.zing.zalo.zalosdk.oauth.ZaloSDKApplication;

public class MyApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        ZaloSDKApplication.wrap(this);
    }
}
package com.example.login_zalo;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull; // <-- Add this line
import io.flutter.embedding.engine.FlutterEngine; // <-- Add this line
import io.flutter.plugins.GeneratedPluginRegistrant; // <-- Add this line

import android.content.Intent; // <-- Add this line
import com.zing.zalo.zalosdk.oauth.ZaloSDK; // Add this line
public class MainActivity extends FlutterActivity {
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        ZaloSDK.Instance.onActivityResult(this, requestCode, resultCode, data); // Add this line
    }
}

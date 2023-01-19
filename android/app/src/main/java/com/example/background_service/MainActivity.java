package com.example.background_service;

import io.flutter.embedding.android.FlutterActivity;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.widget.Toast;
import io.flutter.plugin.common.MethodChannel;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    private String CHANNEL = "com.example.background_service/backgroundService";
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        Intent intent = new Intent(this, HelloService.class);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("showToast")) {
                                String message = call.argument("message");
                                showToast(message);
                                result.success("Success");
                            }else if(call.method.equals("startService")){
                                runService(intent);
                            }else if(call.method.equals("stopService")){
                                killService(intent);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private boolean showToast(String message) {
        Toast.makeText(this, "Service Start", Toast.LENGTH_SHORT).show();
        return true;
    }

    private void runService(Intent intent) {
        Context context = getApplicationContext();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(intent);
        }
    }

    private void killService(Intent intent) {
        stopService(intent);
    }
}

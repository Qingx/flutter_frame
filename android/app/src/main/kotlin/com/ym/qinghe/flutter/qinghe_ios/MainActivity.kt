package com.ym.qinghe.flutter.qinghe_ios

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity(), DeviceKeyMonitor.OnKeyListener {
    private var monitor: DeviceKeyMonitor? = null

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        Log.e("okhttp", "onRecentClick")

        monitor = DeviceKeyMonitor(this, this)
    }


    override fun onDestroy() {
        super.onDestroy()
        monitor?.unregister()
    }

    override fun onRecentClick() {
        Log.e("okhttp", "onRecentClick")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        StartPageManager.configureFlutterEngineForFreshchat(flutterEngine, this)
        flutterEngine.plugins.add(TestViewPlugin())
    }
}

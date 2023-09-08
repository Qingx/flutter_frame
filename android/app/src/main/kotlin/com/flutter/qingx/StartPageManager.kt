package com.flutter.qingx

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class StartPageManager {
    companion object {
        private const val CHANNEL = "startPageChannel"
        private const val PageMethod = "webviewMethod"

        fun configureFlutterEngineForFreshchat(flutterEngine: FlutterEngine, context: Context) {
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL
            ).apply {
                setMethodCallHandler { call, result ->
                    when (call.method) {
                        PageMethod -> {
                            TestActivity.start(context)
                            result.success("done")
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
            }
        }
    }
}
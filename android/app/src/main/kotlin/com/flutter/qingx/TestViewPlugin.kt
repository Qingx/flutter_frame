package com.flutter.qingx

import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin

class TestViewPlugin(
    private val activity: Activity
) : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.apply {
            platformViewRegistry.registerViewFactory(
                "android.testView", TestViewFactory(activity, binaryMessenger)
            )
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
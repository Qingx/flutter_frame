package com.ym.qinghe.flutter.qinghe_ios

import io.flutter.embedding.engine.plugins.FlutterPlugin

class TestViewPlugin() : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.apply {
            platformViewRegistry.registerViewFactory(
                "android.testView", TestViewFactory(binaryMessenger)
            )
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
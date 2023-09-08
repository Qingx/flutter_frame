package com.flutter.qingx

import android.app.Activity
import android.content.Context
import android.view.View
import android.widget.TextView
import com.trustlyAndroidLibrary.TrustlyEventHandler
import com.trustlyAndroidLibrary.TrustlySDKEventObject
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView

class TestView(
    private val activity: Activity,
    context: Context,
    val messenger: BinaryMessenger,
    viewId: Int,
    private var args: Any?
) : PlatformView {
    private var nativeView: View? = null

    companion object {
        const val testCheckUrl =
            "https://checkout.test.trustly.com/checkout?OrderID=13595627702&SessionID=03ea7ae8-7df6-44e3-ba51-35ee72d67cb5"
    }

    init {
        args = testCheckUrl
        val eventHandler = object : TrustlyEventHandler {
            override fun onTrustlyCheckoutSuccess(p0: TrustlySDKEventObject?) {
                BasicMessageChannel(messenger, "aa", StandardMessageCodec()).also {
                    it.send("onTrustlyCheckoutSuccess")
                }
            }

            override fun onTrustlyCheckoutRedirect(p0: TrustlySDKEventObject?) {
                TODO("Not yet implemented")
            }

            override fun onTrustlyCheckoutAbort(p0: TrustlySDKEventObject?) {
                TODO("Not yet implemented")
            }

            override fun onTrustlyCheckoutError(p0: TrustlySDKEventObject?) {
                TODO("Not yet implemented")
            }
        }

        val trustlyWebView = MyTrustlyWebView(activity, args as String, eventHandler)

        val textView = TextView(context).apply {
            text = args as? String
            setOnClickListener {
                BasicMessageChannel(messenger, "aa", StandardMessageCodec()).also {
                    it.send("a message from android")
                }
            }
        }

        nativeView = trustlyWebView
    }

    override fun getView(): View {
        return nativeView!!
    }

    override fun dispose() {
        if (nativeView != null) {
            nativeView = null
        }
    }
}
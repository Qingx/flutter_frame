package com.ym.qinghe.flutter.qinghe_ios

import android.content.Context
import android.util.Log
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.trustlyAndroidLibrary.TrustlyEventHandler
import com.trustlyAndroidLibrary.TrustlySDKEventObject
import com.trustlyAndroidLibrary.TrustlyWebView
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView

class TestView(
    context: Context,
    private val messenger: BinaryMessenger,
    viewId: Int,
    args: Any?
) : PlatformView {
    private var nativeView: View? = null

    init {
        Log.e("okhttp","nativeView")
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

//        val trustlyWebView = TrustlyWebView(
//            context as AppCompatActivity,
//            "https://checkout.test.trustly.com/checkout?OrderID=13595627702&SessionID=03ea7ae8-7df6-44e3-ba51-35ee72d67cb5",
//            eventHandler
//        )

        val textView = TextView(context).apply {
            text = args as? String
            setOnClickListener {
                BasicMessageChannel(messenger, "aa", StandardMessageCodec()).also {
                    it.send("a message from android")
                }
            }
        }

        nativeView = textView
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
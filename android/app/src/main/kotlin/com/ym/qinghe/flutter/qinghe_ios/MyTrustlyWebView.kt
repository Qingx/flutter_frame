package com.ym.qinghe.flutter.qinghe_ios

import android.annotation.SuppressLint
import android.app.Activity
import android.util.Log
import android.view.ViewGroup
import android.view.ViewGroup.LayoutParams
import android.webkit.WebView
import android.webkit.WebViewClient
import com.trustlyAndroidLibrary.TrustlyEventHandler
import com.trustlyAndroidLibrary.TrustlyJavascriptInterface
import com.trustlyAndroidLibrary.WebSettingsException

@SuppressLint("ViewConstructor")
class MyTrustlyWebView(
    activity: Activity,
    url: String,
    trustlyEventHandler: TrustlyEventHandler,
) : WebView(activity) {

    init {
        tryOpeningUrlInWebView(activity, url, trustlyEventHandler)
    }

    private fun tryOpeningUrlInWebView(
        activity: Activity,
        url: String,
        trustlyEventHandler: TrustlyEventHandler
    ) {
        try {
            configWebSettings(this)
            this.apply {
                webViewClient = WebViewClient()
                webChromeClient = MyTrustlyWebChromeClient()
                addJavascriptInterface(
                    TrustlyJavascriptInterface(activity, trustlyEventHandler),
                    "TrustlyAndroid"
                )
                layoutParams = ViewGroup.LayoutParams(LayoutParams(-1, -1))
                loadUrl(url)
            }
        } catch (exception: WebSettingsException) {
            Log.e("trustlyAndroid", "configWebView: Could not config WebSettings")
        } catch (exception: Exception) {
            Log.e("trustlyAndroid", "configWebView: Unknown Problem happened")
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun configWebSettings(webView: WebView) {
        try {
            webView.settings.apply {
                javaScriptEnabled = true
                domStorageEnabled = true
                javaScriptCanOpenWindowsAutomatically = true
                setSupportMultipleWindows(true)
            }
        } catch (exception: Exception) {
            throw WebSettingsException(exception.message)
        }
    }
}
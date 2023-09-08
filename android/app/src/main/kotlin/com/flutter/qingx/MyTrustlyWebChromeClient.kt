package com.flutter.qingx

import android.os.Message
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebView.WebViewTransport
import android.webkit.WebViewClient
import androidx.browser.customtabs.CustomTabsIntent
import java.lang.ref.WeakReference

class MyTrustlyWebChromeClient : WebChromeClient() {

    override fun onCreateWindow(
        view: WebView,
        isDialog: Boolean,
        isUserGesture: Boolean,
        resultMsg: Message
    ): Boolean {

        val webview = WeakReference(WebView(view.context)).get()
        return if (webview != null) {
            webview.webViewClient = Client()
            val transport = resultMsg.obj as WebViewTransport
            transport.webView = webview
            resultMsg.sendToTarget()
            true
        } else {
            false
        }
    }

    private class Client : WebViewClient() {
        override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
            val builder = CustomTabsIntent.Builder()
            val customTab = builder.build()
            customTab.launchUrl(view.context, request.url)
            return true
        }
    }
}
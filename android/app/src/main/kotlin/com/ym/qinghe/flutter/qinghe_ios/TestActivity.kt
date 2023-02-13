package com.ym.qinghe.flutter.qinghe_ios

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.trustlyAndroidLibrary.TrustlyWebView
import io.flutter.plugin.common.BinaryMessenger
import kotlinx.android.synthetic.main.activity_test.*

class TestActivity : AppCompatActivity() {

    companion object {
        fun start(context: Context?) {
            val intent = Intent(context, TestActivity::class.java)
                .apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                }
            context!!.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_test)

        val trustlyWebView = TrustlyWebView(
            this,
            "https://checkout.test.trustly.com/checkout?OrderID=13595627702&SessionID=03ea7ae8-7df6-44e3-ba51-35ee72d67cb5"
        )

        web_view.addView(trustlyWebView)
    }

    override fun onBackPressed() {
        super.onBackPressed()
    }
}
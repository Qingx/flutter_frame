package com.flutter.qingx

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.flutter.qingx.databinding.ActivityTestBinding
import com.trustlyAndroidLibrary.TrustlyWebView

class TestActivity : AppCompatActivity() {

    private lateinit var binding: ActivityTestBinding

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
        binding = ActivityTestBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val trustlyWebView = TrustlyWebView(
            this,
            "https://checkout.test.trustly.com/checkout?OrderID=13595627702&SessionID=03ea7ae8-7df6-44e3-ba51-35ee72d67cb5"
        )

        binding.webView.addView(trustlyWebView)
    }

    override fun onBackPressed() {
        super.onBackPressed()
    }
}
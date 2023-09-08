package com.flutter.qingx

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log

class DeviceKeyMonitor(private val mContext: Context, private val mListener: OnKeyListener) {
    companion object {
        const val SYSTEM_REASON = "reason"
        const val SYSTEM_HOME_RECENT_APPS = "recentApps"
    }

    private var mReceiver: BroadcastReceiver? = null

    init {
        doInit()
    }

    private fun doInit() {
        Log.e("okhttp", "doInit")
        mReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val action = intent?.action
                if (!action.isNullOrEmpty()) {
                    if (action == Intent.ACTION_CLOSE_SYSTEM_DIALOGS) {
                        val reason = intent.getStringExtra(SYSTEM_REASON)
                        if (reason.isNullOrEmpty()) return

                        if (reason == SYSTEM_HOME_RECENT_APPS) {
                            mListener.onRecentClick()
                        }
                    }
                }
            }
        }
        mContext.registerReceiver(mReceiver, IntentFilter(Intent.ACTION_CLOSE_SYSTEM_DIALOGS))
    }

    interface OnKeyListener {
        fun onRecentClick()
    }

    fun unregister() {
        if (mReceiver != null) {
            mContext.unregisterReceiver(mReceiver)
            mReceiver = null
        }
    }
}
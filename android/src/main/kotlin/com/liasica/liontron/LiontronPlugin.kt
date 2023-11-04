package com.liasica.liontron

import android.annotation.SuppressLint
import android.os.Build
import com.lztek.toolkit.Lztek
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** LiontronPlugin */
class LiontronPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var lztek: Lztek

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "liontron")
        channel.setMethodCallHandler(this)
        lztek = Lztek.create(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> getPlatformVersion(result)
            "getEthMacAddress" -> getEthMacAddress(result)
            "getSerialNumber" -> getSerialNumber(result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getPlatformVersion(result: Result) {
        result.success("Android ${Build.VERSION.RELEASE}")
    }

    private fun getEthMacAddress(result: Result) {
        result.success(lztek.ethMac)
    }

    @SuppressLint("HardwareIds")
    private fun getSerialNumber(result: Result) {
        result.success(
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                Build.getSerial() ?: ""
            } else {
                Build.SERIAL ?: ""
            }
        )
    }
}

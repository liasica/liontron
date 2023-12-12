package com.liasica.liontron

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.StatFs
import com.lztek.toolkit.Lztek
import io.flutter.Log
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
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "liontron")
        channel.setMethodCallHandler(this)

        lztek = Lztek.create(context)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> getPlatformVersion(result)
            "getEthMacAddress" -> getEthMacAddress(result)
            "getSerialNumber" -> getSerialNumber(result)
            "getInternalStoragePath" -> getInternalStoragePath(result)
            "getStorageCardPath" -> getStorageCardPath(result)
            "getUsbStoragePath" -> getUsbStoragePath(result)
            "getStorageSize" -> getStorageSize(call, result)
            "installApplication" -> installApplication(call, result)
            "setKeepAlive" -> setKeepAlive(call, result)
            "setBoot" -> setBoot(call, result)
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

    private fun getInternalStoragePath(result: Result) {
        result.success(lztek.internalStoragePath)
    }

    private fun getStorageCardPath(result: Result) {
        result.success(lztek.storageCardPath)
    }

    private fun getUsbStoragePath(result: Result) {
        result.success(lztek.usbStoragePath)
    }

    private fun getStorageSize(call: MethodCall, result: Result) {
        val path = call.arguments as String
        val statfs = StatFs(path)
        val blocSize = statfs.blockSizeLong
        val availableSize = statfs.availableBlocksLong * blocSize
        val totalSize = statfs.blockCountLong * blocSize
        result.success(hashMapOf("totalSize" to totalSize, "availableSize" to availableSize))
    }

    private fun installApplication(call: MethodCall, result: Result) {
        val apkPath = call.argument<String>("apkPath")
        result.success(lztek.installApplication(apkPath))
    }

    private fun setKeepAlive(call: MethodCall, result: Result) {
        val map = call.arguments as Map<*, *>?
        map?.let {
            try {
                val unset = it["unset"] as Boolean? ?: false
                val packageName = it["packageName"] as String
                val delaySeconds = it["delaySeconds"] as Int? ?: 5
                val foreground = it["foreground"] as Boolean? ?: true


                var action = "com.lztek.tools.action.KEEPALIVE_SETUP"
                if (unset) {
                    action = "com.lztek.tools.action.KEEPALIVE_UNSET"
                }
                val intent = Intent(action)

                intent.putExtra("packageName", packageName)

                if (!unset) {
                    intent.putExtra("delaySeconds", delaySeconds)
                    intent.putExtra("foreground", foreground)
                }

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) intent.setPackage("com.lztek.bootmaster.autoboot7")

                context.sendBroadcast(intent)
                result.success(true)
            } catch (e: Throwable) {
                Log.e("liontron", "${e.message}", e)
                result.success(false)
            }
        }
    }

    private fun setBoot(call: MethodCall, result: Result) {
        val map = call.arguments as Map<*, *>?
        map?.let {
            try {
                val unset = it["unset"] as Boolean? ?: false
                val packageName = it["packageName"] as String
                val delaySeconds = it["delaySeconds"] as Int? ?: 5


                var action = "com.lztek.tools.action.BOOT_SETUP"
                if (unset) {
                    action = "com.lztek.tools.action.BOOT_UNSET"
                }
                val intent = Intent(action)

                intent.putExtra("packageName", packageName)

                if (!unset) {
                    intent.putExtra("delaySeconds", delaySeconds)
                }

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) intent.setPackage("com.lztek.bootmaster.autoboot7")

                context.sendBroadcast(intent)
                result.success(true)
            } catch (e: Throwable) {
                Log.e("liontron", "${e.message}", e)
                result.success(false)
            }
        }
    }
}

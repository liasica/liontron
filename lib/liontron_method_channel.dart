import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'liontron_platform_interface.dart';

/// An implementation of [LiontronPlatform] that uses method channels.
class MethodChannelLiontron extends LiontronPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('liontron');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getEthMacAddress() async {
    return await methodChannel.invokeMethod<String>('getEthMacAddress');
  }

  @override
  Future<String?> getSerialNumber() async {
    return await methodChannel.invokeMethod<String>('getSerialNumber');
  }

  @override
  Future<String?> getInternalStoragePath() async {
    return await methodChannel.invokeMethod<String>('getInternalStoragePath');
  }

  @override
  Future<String?> getStorageCardPath() async {
    return await methodChannel.invokeMethod<String>('getStorageCardPath');
  }

  @override
  Future<String?> getUsbStoragePath() async {
    return await methodChannel.invokeMethod<String>('getUsbStoragePath');
  }

  @override
  Future<Map<String, dynamic>?> getStorageSize(String path) async {
    final result = await methodChannel.invokeMethod('getStorageSize', path);
    return result == null ? null : Map<String, dynamic>.from(result);
  }

  @override
  Future<String?> installApplication(String apkPath) async {
    return await methodChannel.invokeMethod<String>(
      'installApplication',
      {'apkPath': apkPath},
    );
  }

  @override
  Future<bool?> setKeepAlive(
    String packageName, {
    bool? unset = false,
    int? delaySeconds = 5,
    bool? foreground = true,
  }) async {
    return await methodChannel.invokeMethod<bool>('setKeepAlive', {
      'packageName': packageName,
      'unset': unset,
      'delaySeconds': delaySeconds,
      'foreground': foreground,
    });
  }

  @override
  Future<bool?> setBoot(
    String packageName, {
    bool? unset = false,
    int? delaySeconds = 5,
  }) async {
    return await methodChannel.invokeMethod<bool>('setBoot', {
      'packageName': packageName,
      'unset': unset,
      'delaySeconds': delaySeconds,
    });
  }
}

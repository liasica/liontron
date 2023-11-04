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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
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
}

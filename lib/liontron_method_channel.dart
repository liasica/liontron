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
  Future<String?> getMacAddress() async {
    return await methodChannel.invokeMethod<String>('getMacAddress');
  }

  @override
  Future<String?> getSerialNumber() async {
    return await methodChannel.invokeMethod<String>('getSerialNumber');
  }
}

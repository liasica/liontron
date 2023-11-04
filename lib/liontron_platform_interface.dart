import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'liontron_method_channel.dart';

abstract class LiontronPlatform extends PlatformInterface {
  /// Constructs a LiontronPlatform.
  LiontronPlatform() : super(token: _token);

  static final Object _token = Object();

  static LiontronPlatform _instance = MethodChannelLiontron();

  /// The default instance of [LiontronPlatform] to use.
  ///
  /// Defaults to [MethodChannelLiontron].
  static LiontronPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LiontronPlatform] when
  /// they register themselves.
  static set instance(LiontronPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getEthMacAddress() {
    throw UnimplementedError('getEthMacAddress() has not been implemented.');
  }

  Future<String?> getSerialNumber() {
    throw UnimplementedError('getSerialNumber() has not been implemented.');
  }

  Future<String?> getInternalStoragePath() {
    throw UnimplementedError('getInternalStoragePath() has not been implemented.');
  }

  Future<String?> getStorageCardPath() {
    throw UnimplementedError('getStorageCardPath() has not been implemented.');
  }

  Future<String?> getUsbStoragePath() {
    throw UnimplementedError('getUsbStoragePath() has not been implemented.');
  }

  Future<Map<String, dynamic>?> getStorageSize(String path) {
    throw UnimplementedError('getStorageSize() has not been implemented.');
  }
}

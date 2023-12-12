import 'package:liontron/models/storage_size.dart';

import 'liontron_platform_interface.dart';

class Liontron {
  Future<String?> getPlatformVersion() {
    return LiontronPlatform.instance.getPlatformVersion();
  }

  /// 获取以太网MAC地址
  Future<String?> getEthMacAddress() {
    return LiontronPlatform.instance.getEthMacAddress();
  }

  /// 获取序列号
  Future<String?> getSerialNumber() {
    return LiontronPlatform.instance.getSerialNumber();
  }

  /// 获取内部存储路径
  Future<String?> getInternalStoragePath() {
    return LiontronPlatform.instance.getInternalStoragePath();
  }

  /// 获取存储卡路径
  Future<String?> getStorageCardPath() {
    return LiontronPlatform.instance.getStorageCardPath();
  }

  /// 获取USB存储路径
  Future<String?> getUsbStoragePath() {
    return LiontronPlatform.instance.getUsbStoragePath();
  }

  /// 获取存储大小
  Future<StorageSize?> getStorageSize(String path) async {
    // return LiontronPlatform.instance.getStorageSize(path);
    final result = await LiontronPlatform.instance.getStorageSize(path);
    return result == null ? null : StorageSize.fromJson(result);
  }

  /// 应用静默安装
  Future<String?> installApplication(String apkPath) async {
    return LiontronPlatform.instance.installApplication(apkPath);
  }

  /// 设置应用保活
  Future<bool?> setKeepAlive(
    String packageName, {
    bool? unset = false,
    int? delaySeconds = 5,
    bool? foreground = true,
  }) async {
    return LiontronPlatform.instance.setKeepAlive(
      packageName,
      unset: unset,
      delaySeconds: delaySeconds,
      foreground: foreground,
    );
  }

  /// 设置开机自启动
  Future<bool?> setBoot(
    String packageName, {
    bool? unset = false,
    int? delaySeconds = 5,
  }) async {
    return LiontronPlatform.instance.setBoot(
      packageName,
      unset: unset,
      delaySeconds: delaySeconds,
    );
  }
}

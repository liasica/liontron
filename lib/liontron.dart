import 'liontron_platform_interface.dart';

class Liontron {
  Future<String?> getPlatformVersion() {
    return LiontronPlatform.instance.getPlatformVersion();
  }

  Future<String?> getMacAddress() {
    return LiontronPlatform.instance.getMacAddress();
  }

  Future<String?> getSerialNumber() {
    return LiontronPlatform.instance.getSerialNumber();
  }
}

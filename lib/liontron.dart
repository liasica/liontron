import 'liontron_platform_interface.dart';

class Liontron {
  Future<String?> getPlatformVersion() {
    return LiontronPlatform.instance.getPlatformVersion();
  }

  Future<String?> getEthMacAddress() {
    return LiontronPlatform.instance.getEthMacAddress();
  }

  Future<String?> getSerialNumber() {
    return LiontronPlatform.instance.getSerialNumber();
  }
}

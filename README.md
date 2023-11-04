# 亮钻科技SDK

使用该SDK之前需要先获取系统权限, `AndroidMainfest.xml`中需要设定`android:sharedUserId="android.uid.system"`

例如: 
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:sharedUserId="android.uid.system">
</manifest>
```

## 实现功能
- `getEthMacAddress` 获取网口Mac地址
- `getSerialNumber` 获取序列号(需要获取系统权限`7.1-11`)
- `getInternalStoragePath` 获取内部存储路径
- `getStorageCardPath` 获取存储卡路径
- `getUsbStoragePath` 获取USB存储路径
- `getStorageSize` 获取存储大小
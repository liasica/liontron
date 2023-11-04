# 亮钻科技SDK

使用该SDK之前需要先获取系统权限, `AndroidMainfest.xml`中需要加入`<uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" tools:ignore="ProtectedPermissions" />`

例如: 
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.liasica.liontron">

    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"
        tools:ignore="ProtectedPermissions" />
</manifest>
```

## 实现功能
- `getEthMacAddress` 获取网口Mac地址
- `getSerialNumber` 获取序列号(需要获取系统权限`7.1-11`)
- `getInternalStoragePath` 获取内部存储路径
- `getStorageCardPath` 获取存储卡路径
- `getUsbStoragePath` 获取USB存储路径
- `getStorageSize` 获取存储大小
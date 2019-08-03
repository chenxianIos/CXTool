//
//  NSString+Device.h
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXDevice)


/**
 判断设备型号
 */
+ (NSString*)deviceModelName;

/**
 获取设备 IP
 */
+ (NSString *)deviceIPAdress;

/** app名称  */
+ (NSString *)app_Name;

/** app版本  */
+ (NSString *)app_Version;

/** app build版本    */
+ (NSString *)app_build;

/** 手机别名： 用户定义的名称    */
+ (NSString *)userPhoneName;

/** 设备名称   */
+ (NSString *)deviceName;

/** 手机系统版本  */
+ (NSString *)phoneVersion;

/** 手机型号   */
+ (NSString *)phoneModel;

/** 地方型号  （国际化区域名称）  */
+ (NSString *)localPhoneModel;

//获取手机uuId
+ (NSString *)getUniqueStrByUUID;

//** 磁盘可用空间大小 */
+ (CGFloat)diskOfFreeSizeMBytes;

//** 磁盘总空间大小 */
+ (CGFloat)diskOfAllSizeMBytes;






@end

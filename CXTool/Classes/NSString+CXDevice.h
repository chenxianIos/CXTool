//
//  NSString+Device.h
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXDevice)


/** 获取设备型号 */
+ (NSString *)deviceModelName;

/** 获取设备 IP  */
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
+ (NSString *)systemName;

/** 手机系统版本  */
+ (NSString *)systemVersion;

/** 手机型号   */
+ (NSString *)phoneModel;

/** 地方型号  （国际化区域名称）  */
+ (NSString *)localPhoneModel;

/** 获取手机uuId */
+ (NSString *)getUniqueStrByUUID;

/** 磁盘可用空间大小 */
+ (CGFloat)diskOfFreeSizeMBytes;

/** 磁盘总空间大小 */
+ (CGFloat)diskOfAllSizeMBytes;

/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *  @param number 身份证
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number;

/**
 *  从身份证里面获取性别man-1 或者 woman-2 不正确的身份证返回-3
 *  @param number 身份证
 */
+ (NSInteger)getGenderFromIdentityNumber:(NSString *)number;

/**
 *  判断身份证是否合法
 *  @param number 身份证号码
 */
+ (BOOL)checkIdentityNumber:(NSString *)number;


@end

//
//  NSString+Device.m
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import "NSString+CXDevice.h"
#import <sys/utsname.h>

#import <arpa/inet.h>
#import <ifaddrs.h>

@implementation NSString (CXDevice)

+ (NSString*)deviceModelName

{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    
    //iPhone 系列
    
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    if ([deviceModel isEqualToString:@"iPhone10,1"])    return @"iPhone 8 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone10,3"])    return @"iPhone 8 (GSM)";
    
    if ([deviceModel isEqualToString:@"iPhone10,4"])    return @"iPhone 8 Plus (GSM)";
    
    if ([deviceModel isEqualToString:@"iPhone10,5"])    return @"iPhone X (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone10,6"])    return @"iPhone X (GSM)";
    
    
    //iPod 系列
    
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    
    
    //iPad 系列
    
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        
        ||[deviceModel isEqualToString:@"iPad4,5"]
        
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        
        ||[deviceModel isEqualToString:@"iPad4,8"]
        
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    
    
    return deviceModel;
    
}

+ (NSString *)deviceIPAdress
{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    NSLog(@"手机的IP是：%@", address);
    return address;
}

+ (NSString *)app_Name{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)app_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)app_build{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)userPhoneName{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemName{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)localPhoneModel{
    return [[UIDevice currentDevice] localizedModel];
}

+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return [uuid lowercaseString];
}


+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

#pragma mark - 身份证相关
/**
 *  判断身份证是否合法
 *
 *  @param number 身份证号码
 *
 *  @return
 */
+ (BOOL)checkIdentityNumber:(NSString *)number
{
    {
        //必须满足以下规则
        //1. 长度必须是18位或者15位，前17位必须是数字，第十八位可以是数字或X
        //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
        //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
        //4. 第17位表示性别，双数表示女，单数表示男
        //5. 第18位为前17位的校验位
        //算法如下：
        //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
        //（2）余数 ＝ 校验和 % 11
        //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
        //6. 出生年份的前两位必须是19或20
        number = [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        number = [self filterSpecialString:number];
        //1⃣️判断位数
        if (number.length != 15 && number.length != 18) {
            return NO;
        }
        //2⃣️将15位身份证转为18位
        NSMutableString *mString = [NSMutableString stringWithString:number];
        if (number.length == 15) {
            //出生日期加上年的开头
            [mString insertString:@"19" atIndex:6];
            //最后一位加上校验码
            [mString insertString:[self getLastIdentifyNumberForIdentifyNumber:mString] atIndex:[mString length]];
            number = mString;
        }
        //3⃣️开始判断
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        //区域
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if (![regexTest evaluateWithObject:number]) {
            return NO;
        }
        //4⃣️验证校验码
        return [[self getLastIdentifyNumberForIdentifyNumber:number] isEqualToString:[number substringWithRange:NSMakeRange(17, 1)]];
    }
}
+ (NSString *)getLastIdentifyNumberForIdentifyNumber:(NSString *)number {
    //位数不小于17
    if (number.length < 17) {
        return nil;
    }
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    long p =0;
    for (int i =0; i<=16; i++){
        NSString * s = [number substringWithRange:NSMakeRange(i, 1)];
        p += [s intValue]*R[i];
    }
    //校验位
    int o = p%11;
    NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
    return string_content;
}

/**
 *  从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 *
 *  @param number 身份证
 *
 *  @return
 */
+ (NSInteger)getGenderFromIdentityNumber:(NSString *)number
{
    if ([self checkIdentityNumber:number]) {
        number = [self filterSpecialString:number];
        NSInteger i = [[number substringWithRange:NSMakeRange(number.length - 2, 1)] integerValue];
        if (i % 2 == 1) {
            return 1;
        } else {
            return 2;
        }
    } else {
        return 3;
    }
}
/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *
 *  @param number 身份证
 *
 *  @return
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number
{
    if ([self checkIdentityNumber:number]) {
        number = [self filterSpecialString:number];
        if (number.length == 18) {
            return [NSString stringWithFormat:@"%@年%@月%@日",[number substringWithRange:NSMakeRange(6,4)], [number substringWithRange:NSMakeRange(10,2)], [number substringWithRange:NSMakeRange(12,2)]];
        }
        if (number.length == 15) {
            return [NSString stringWithFormat:@"19%@年%@月%@日",[number substringWithRange:NSMakeRange(6,2)], [number substringWithRange:NSMakeRange(8,2)], [number substringWithRange:NSMakeRange(10,2)]];
        };
        return nil;
    } else {
        return nil;
    }
}


@end









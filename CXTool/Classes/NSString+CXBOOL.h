//
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXBOOL)

- (BOOL)isEmpty;

/** 判断是否含有空格 */
- (BOOL)isContainWhiteCharacter;

/** 当前字符串是否只包含空白字符和换行符 */
- (BOOL)isWhitespaceAndNewlines;

/** 判断是否为整形 */
- (BOOL)isPureInt;

/** 判断是否为浮点形 */
- (BOOL)isPureFloat;

/** 判断为英文 */
- (BOOL)isEnglish;

/** 是否包含中文 */
- (BOOL)isContainChinese;

/** 判断是否是纯汉字 */
- (BOOL)isChinese;

/** 是否含有表情符号 */
-(BOOL)isContainsEmoji;

/**
 *  手机号码的有效性:更新时间： 2019 - 01 - 02
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  身份证有效性
 *
 */
- (BOOL)isIDCardNumber;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isUrl;

/**
 *  邮政编码
 */
- (BOOL)isPostalcode;


//以给定字符串开始,忽略大小写
- (BOOL)startsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串开始
- (BOOL)startsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;


//以给定字符串结束，忽略大小写
- (BOOL)endsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串结尾
- (BOOL)endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//包含给定的字符串, 忽略大小写
- (BOOL)containsString:(NSString *)str;
//以指定条件判断是否包含给定的字符串
- (BOOL)containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//判断字符串是否相同，忽略大小写
- (BOOL)equalsString:(NSString *)str;


@end

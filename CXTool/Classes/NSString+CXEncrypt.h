//
//  NSString+Encrypt.h
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXEncrypt)

/** 加密 */
- (NSString *)MD5;
- (NSString *)MD5_16;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;


//编码
-(NSString*)Base64EnCoded;
//解码
-(NSString*)Base64DeCoded;



@end

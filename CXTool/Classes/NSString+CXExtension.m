

#import "NSString+CXExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"


#define HANZI_START 19968
#define HANZI_COUNT 20902



@implementation NSString (CXExtension)



+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte{
    NSString *sizeDisplayStr;
    if (sizeOfByte < 1024) {
        sizeDisplayStr = [NSString stringWithFormat:@"%.2f bytes", sizeOfByte];
    }else{
        CGFloat sizeOfKB = sizeOfByte/1024;
        if (sizeOfKB < 1024) {
            sizeDisplayStr = [NSString stringWithFormat:@"%.2f KB", sizeOfKB];
        }else{
            CGFloat sizeOfM = sizeOfKB/1024;
            if (sizeOfM < 1024) {
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f M", sizeOfM];
            }else{
                CGFloat sizeOfG = sizeOfKB/1024;
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f G", sizeOfG];
            }
        }
    }
    return sizeDisplayStr;
}



- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

//转换拼音
- (NSString *)transformToPinyin {
    if (self.length <= 0) {
        return self;
    }
    NSMutableString *tempString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [tempString uppercaseString];
}

//字符串 去掉各种字符
- (NSString *)contactCharacterSetWithCharactersInString
{
    NSString *noQianzhui = [self formatPhoneNum:self];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@ －（）-().·[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+"];
    NSString *trimmedString = [noQianzhui stringByTrimmingCharactersInSet:doNotWant];
    NSString *tempString = [trimmedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return tempString;
    
}

- (NSString *)formatPhoneNum:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]||[phone hasPrefix:@"+86 "]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }else if([phone hasPrefix:@"+86  "]||[phone hasPrefix:@"+86··"]){
            NSString *formatStr = [phone substringWithRange:NSMakeRange(5, [phone length]-5)];
            return formatStr;
        }else{
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    
    return phone;
    
}

//base64加密
+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* str=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData* data=[str dataUsingEncoding:NSUTF8StringEncoding];
    NSData* base64=[data base64EncodedDataWithOptions:0];
    NSString* base64Decoded=[[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return base64Decoded;
}




//去掉字符串中的特殊符号
- (NSString *)trimCharacterSet:(NSCharacterSet *)characterSet {
    NSString *returnVal = @"";
    if (self) {
        returnVal = [self stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}


- (NSUInteger)utf8Length
{
    size_t length = strlen([self UTF8String]);
    return length;
}

+(NSString*)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date=[NSDate date];
    NSString * strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//获取今月
+ (NSString *)getThisMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%ld-%02ld",(long)[components year],(long)[components month]];
    
}
//获取今天时间
+ (NSString *)getToday
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)[components year],(long)[components month],(long)[components day]];
    
}
//获取昨天时间
+ (NSString *)getYestoday
{
    NSString *dateString = [self getToday];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateFormat:@"yyyy-MM-dd"];
    
        NSDate *date = [formatter dateFromString:dateString];
    
        NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    
    return [formatter stringFromDate:yesterday];
}
//获取明天时间
+ (NSString *)getTomorrow
{
    NSString *dateString = [self getToday];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    
    return [formatter stringFromDate:tomorrow];
}
//词典转换为字符串
+(NSString*)dictionaryToNOJiaMiJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


//此方法可以获取文件的大小，返回的是单位是KB。
+(CGFloat) getFileSize:(NSString *)path
{
    //    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if (![fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
        
        //        NSLog(@"文件路径已经存在");
    }
    return filesize;
}


#pragma mark 日期和时间计算
+(NSString *)formateDate:(NSString *)dateString withFormate:(NSString *)formate
{
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        NSDate * nowDate = [NSDate date];
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  // 1分钟以内的
            
            dateStr = @"刚刚";
        }else if(time<=60*60){  //  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   // 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                // 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
                NSLog(@"%@", dateStr);
            }else{
                //  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                //  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
            
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - 计算时间
+(NSString*)caculateTime:(NSString*)str
{
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
   NSDate *curDate = [NSDate date];
   
   //今天
   if([str isEqualToString:@"1"]) {
      curDate = [NSDate dateWithTimeIntervalSinceNow:-(60*60*0)];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSString *strDate = [dateFormatter stringFromDate:curDate];
      NSString *caculateDate = [strDate stringByAppendingString:@" 00:00:00"];
      return caculateDate;
   }
   //过去3天
   else if([str isEqualToString:@"3"]) {
      curDate = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*3)];
   }
   //过去7天
   else if([str isEqualToString:@"7"]) {
      curDate = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*7)];
   }
   //过去30天
   else if([str isEqualToString:@"30"]) {
      curDate = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*30)];
   }
    
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   NSString *strDate = [dateFormatter stringFromDate:curDate];
   strDate = [strDate stringByAppendingString:@" 00:00:00"];
   return strDate;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
       [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        aa=0;
        //        相等  aa=0
    }else if (result==NSOrderedAscending)
    {
        aa=1;
        //bDate比aDate大
    }else if (result==NSOrderedDescending)
    {
        aa=-1;
        //bDate比aDate小
        
    }
    
    return aa;
}

+(long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
+(float)folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//        if ([fileAbsolutePath rangeOfString:@"MCDownloadCache"].location !=NSNotFound) {
//            continue;
//        }
//        else
//        {
//
//        }
        if ([fileAbsolutePath rangeOfString:@"MCDownloadCache"].location !=NSNotFound||[fileAbsolutePath rangeOfString:@"MCDownloadCache/receipts.data"].location !=NSNotFound) {
            
            continue;
        }else
        folderSize += [self fileSizeAtPath:fileAbsolutePath];

//        NSLog(@"\n\n\n=========文件路径=========%@\n\n",fileAbsolutePath);
    }
    return folderSize/(1024.0*1024.0);
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString
{
    if (JSONString.length==0) {
        return nil;
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}


//字符串转时间戳 如：2017-4-10 17:15:10  （十位的）
+(NSString *)getTimeStrWithString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到秒
    return timeStr;
}
//时间戳转时间
+(NSString*)timestampTranferToTime:(NSString*)time
{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[time doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString ;
}

- (NSString *)stringRemoveStr:(NSString *)str
{
    NSString *ctStr = self;
    if ([ctStr length] > 1) {
        if ([ctStr rangeOfString:str].location != NSNotFound) {
            ctStr = [ctStr substringToIndex:([ctStr length]-1)];
        }
    }
    return ctStr;
}




- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)removeNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}


#pragma mark XML Extensions
+ (NSString *)encodeXMLCharactersIn:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&"] componentsJoinedByString:@"&amp;"];
    }
    
    if ([result rangeOfString:@"<"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"<"] componentsJoinedByString:@"&lt;"];
    }
    
    if ([result rangeOfString:@">"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@">"] componentsJoinedByString:@"&gt;"];
    }
    
    if ([result rangeOfString:@"\""].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"\""] componentsJoinedByString:@"&quot;"];
    }
    
    if ([result rangeOfString:@"'"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"'"] componentsJoinedByString:@"&apos;"];
    }
    
    return result;
}

+ (NSString *)decodeXMLCharactersIn:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&amp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&amp;"] componentsJoinedByString:@"&"];
    }
    
    if ([result rangeOfString:@"&lt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&lt;"] componentsJoinedByString:@"<"];
    }
    
    if ([result rangeOfString:@"&gt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&gt;"] componentsJoinedByString:@">"];
    }
    
    if ([result rangeOfString:@"&quot;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&quot;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&apos;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&apos;"] componentsJoinedByString:@"'"];
    }
    
    if ([result rangeOfString:@"&nbsp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&nbsp;"] componentsJoinedByString:@" "];
    }
    
    if ([result rangeOfString:@"&#8220;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8220;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#8221;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8221;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#039;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#039;"] componentsJoinedByString:@"'"];
    }
    return result;
}

- (NSString *)substringAtRange:(NSRange)rang
{
    if (self == nil || [self isEqualToString:@""] || [self isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    if (rang.location > self.length)
    {
        return nil;
    }
    
    if (rang.location + rang.length > self.length)
    {
        return nil;
    }
    
    return [self substringWithRange:rang];
}



+(NSString*)timestampTranferToTimeWithNSDate:(NSDate*)date
{
    //    NSLog(@"=========date====== %@",date);
    
    // 当前时间
    NSDate*  tdate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[tdate timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    //    NSLog(@"=========tdate====== %@",tdate);
    return timeString;
}

- (NSString *)removeHTML{
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    NSString *result = self;
    
    theScanner = [NSScanner scannerWithString:self];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        result = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
    }
    
    return result;
}


+(NSString*)returnTimeType:(NSString*)time
{
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:time];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return result;
    
}


@end

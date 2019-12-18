

#import "NSString+CXExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"


#define HANZI_START 19968
#define HANZI_COUNT 20902



@implementation NSString (CXExtension)

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


- (NSString *)removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)removeNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

//过滤特殊字符串
- (NSString *)removeSpecialString
{
    NSCharacterSet *dontWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+,.;':|/@!? "];
    //stringByTrimmingCharactersInSet只能去掉首尾的特殊字符串
    return [[[self componentsSeparatedByCharactersInSet:dontWant] componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
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

+(NSString*)formateDate:(NSString*)dateString
{
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:dateString];
    
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


//字符串转时间戳 如：2017-4-10 17:15:10  （十位的）
+(NSString *)timestampTranferWithTimeStr:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到秒
    return timeStr;
}
//时间戳转时间
+(NSString*)timestampTranferToTimeStr:(NSString*)time
{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[time doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString ;
}


+(NSString*)timestampTranferWithNSDate:(NSDate*)date
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


@end



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

char pinyinFirstLetter(unsigned short hanzi);
@interface NSString (CXExtension)


//字符串 去掉各种字符「」：“》》：？》？￥%……
- (NSString *)contactCharacterSetWithCharactersInString;
//去除字符串中所有空白
- (NSString *)removeWhiteSpace;
//去除字符串中所有空行
- (NSString *)removeNewLine;

//转换拼音
- (NSString *)transformToPinyin;

//获取当前的时间   @"yyyy-MM-dd"
+ (NSString*)getCurrentTime;
//获取今月
+ (NSString *)getThisMonth;
//获取今天日期
+ (NSString *)getToday;
//获取昨天日期
+ (NSString *)getYestoday;
//获取明天日期
+ (NSString *)getTomorrow;

//日期和时间计算
+(NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;

//比较两个日期的大小  日期格式为@"yyyy-MM-dd HH:mm:ss"
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

//字符串转时间戳 @"yyyy-MM-dd HH:mm:ss" （十位的）
+(NSString *)getTimeStrWithString:(NSString *)str;

//时间戳转时间 @"yyyy-MM-dd HH:mm:ss"
+(NSString*)timestampTranferToTime:(NSString*)time;

//去掉字符串
- (NSString *)stringRemoveStr:(NSString *)str;

- (NSString *)substringAtRange:(NSRange)rang;

//nsdate转时间戳
+(NSString*)timestampTranferToTimeWithNSDate:(NSDate*)date;

//过滤html标签
- (NSString *)removeHTML;

@end



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

char pinyinFirstLetter(unsigned short hanzi);
@interface NSString (CXExtension)

//去除字符串中所有空白
- (NSString *)removeWhiteSpace;
//去除字符串中所有空行
- (NSString *)removeNewLine;
//过滤特殊字符串
- (NSString *)removeSpecialString;

//转换拼音
- (NSString *)transformToPinyin;

//日期和时间计算
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;
//显示 刚刚，几分钟前，几小时前，昨天，前天--@"yyyy-MM-dd HH:mm:ss"
+ (NSString *)formateDate:(NSString*)dateString;

//比较两个日期的大小  日期格式为@"yyyy-MM-dd HH:mm:ss"
+ (NSInteger )compareDate:(NSString*)aDate withDate:(NSString*)bDate;

//时间字符串转时间戳 @"yyyy-MM-dd HH:mm:ss" （十位的）
+ (NSString *)timestampTranferWithTimeStr:(NSString *)str;

//时间戳转时间字符串 @"yyyy-MM-dd HH:mm:ss"
+ (NSString *)timestampTranferToTimeStr:(NSString*)time;

//NSDate转时间戳
+ (NSString *)timestampTranferWithNSDate:(NSDate*)date;

//过滤html标签
- (NSString *)removeHTML;



@end

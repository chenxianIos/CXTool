//
//  CXUtils.h
//  CXTool
//
//  Created by chenxian on 2019/8/23.
//

typedef NS_ENUM(NSUInteger, CaptureType) {
    CaptureTypeSandbox = 0,
    CaptureTypePhotes,
    CaptureTypeBoth,
};

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXUtils : NSObject

/** 获取当前页的控制器 */
+ (UIViewController *)getCurrentVC;

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
// UIView中的safeAreaInsets如果是刘海屏就会发生变化，普通屏幕safeAreaInsets恒等于UIEdgeInsetsZero
+ (BOOL)isNotchScreen;

/** 世界时间转换为本地时间 */
+ (NSDate *)worldDateToLocalDate:(NSDate *)date;

/** 跳转到iOS系统的设置页 */
+ (void)pushToSystemSettingView;

/** 把字符串的某一部分用‘*’代替 */
+ (NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;

/** 字典转字符串 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/** 字符串转字典 */
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/*** 判断只能输入数字 **/
+ (BOOL)limitIputNumberWithText:(NSString *)string;

@end
NS_ASSUME_NONNULL_END

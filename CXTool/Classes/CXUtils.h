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

/**
 *  屏幕截图有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotWithCaptureType:(CaptureType)type;

/**
 *  屏幕截图没有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotNoStatusBarWithCaptureType:(CaptureType)type;

/**
 *  给一个view截图
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageForView:( UIView * _Nonnull )view withCaptureType:(CaptureType)type;

/**
 *  保存image到指定的位置
 *
 *  @param image image
 *  @param type  类型
 */
+ (void)saveImage:(UIImage *)image WithCaptureType:(CaptureType)type;

#pragma mark - NSUserDefault
// 取值
id UserDefaultGetObj(NSString *key)
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

// 存入
void UserDefaultSetObjForKey(id object,NSString *key)
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:object forKey:key];
    [ud synchronize];
}

// 移除
void UserDefaultRemoveObjForKey(NSString *key)
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}

// 清空
void UserDefaultClean()
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [ud synchronize];
}
#pragma mark - SandBox 沙盒相关

NSString *pathDocuments()
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

NSString *pathCaches()
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

/**
 *  Documents/name path
 *
 *  @param name
 *
 *  @return
 */
NSString *pathDocumentsWithFileName(NSString *name)
{
    return [pathDocuments() stringByAppendingString:name];
}

/**
 *  Caches/name path
 *
 *  @param name
 *
 *  @return
 */
NSString *pathCachesWithFileName(NSString *name)
{
    return [pathCaches() stringByAppendingString:name];
}
@end

NS_ASSUME_NONNULL_END

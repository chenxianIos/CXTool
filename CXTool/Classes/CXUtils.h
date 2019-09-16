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
#import <EventKit/EventKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXUtils : NSObject

/** 获取当前页的控制器 */
+ (UIViewController *)getCurrentVC;
/** 跳转到指定 vc */
+ (void)gotoVC:(NSString *)classString;

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
// UIView中的safeAreaInsets如果是刘海屏就会发生变化，普通屏幕safeAreaInsets恒等于UIEdgeInsetsZero
+ (BOOL)isNotchScreen;

+ (BOOL)isIphoneXUp;

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


/** --------------------------------------------------------------------------------------------------- */

typedef void(^ReturnBlock)(BOOL isOpen);
/** 检测是否开启定位: */
+ (void)openLocationServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否允许消息推送: */
+ (void)openMessageNotificationServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启摄像头: */
+ (void)openCaptureDeviceServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启相册: */
+ (void)openAlbumServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启麦克风: */
+ (void)openRecordServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启通讯录: */
+ (void)openContactsServiceWithBolck:(ReturnBlock)returnBolck;
/** 检测是否开启蓝牙: */
+ (void)openPeripheralServiceWithBolck:(ReturnBlock)returnBolck;
/** 检测是否开启日历/备忘录: EKEntityTypeEvent：日历 -- EKEntityTypeReminder：备忘录  */
+ (void)openEventServiceWithBolck:(ReturnBlock)returnBolck withType:(EKEntityType)entityType;
/** 检测是否开启联网: */
+ (void)openEventServiceWithBolck:(ReturnBlock)returnBolck;
/** 检测是否开启健康: */
+ (void)openHealthServiceWithBolck:(ReturnBlock)returnBolck;
/** 检测是否开启Touch ID/Face ID: */
+ (void)openTouchIDServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启Apple Pay: */
+ (void)openApplePayServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启语音识别: */
+ (void)openSpeechServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启媒体资料库/Apple Music: */
+ (void)openMediaPlayerServiceWithBlock:(ReturnBlock)returnBlock;
/** 检测是否开启Siri: */
+ (void)openSiriServiceWithBlock:(ReturnBlock)returnBlock;

/** --------------------------------------------------------------------------------------------------- */


@end
NS_ASSUME_NONNULL_END

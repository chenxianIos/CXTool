//
//  CXUtils.m
//  CXTool
//
//  Created by chenxian on 2019/8/23.
//

#import "CXUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation CXUtils

/// 获取当前页的控制器
+ (UIViewController *)getCurrentVC{
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    NSLog(@"window level: %.0f", window.windowLevel);
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    //从根控制器开始查找
    UIViewController *rootVC = window.rootViewController;
    UIViewController *activityVC = nil;
    
    while (true) {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            activityVC = [(UINavigationController *)rootVC visibleViewController];
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
            activityVC = [(UITabBarController *)rootVC selectedViewController];
        } else if (rootVC.presentedViewController) {
            activityVC = rootVC.presentedViewController;
        } else {
            if (rootVC.childViewControllers.count > 0) {
                activityVC = rootVC.childViewControllers.lastObject;
            } else {
                activityVC = rootVC;
            }
            
        }
        
    }
    
    return activityVC;
}


//世界时间转换为本地时间
+ (NSDate *)worldDateToLocalDate:(NSDate *)date
{
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:date];
    
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [date dateByAddingTimeInterval:offset];
    
    return localDate;
}


+ (BOOL)isAvailableCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        /// 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        /// 不允许,弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted ||
            authorizationStatus == AVAuthorizationStatusDenied) {
            NSString *tipMessage = [NSString stringWithFormat:@"请到手机系统的\n【设置】->【隐私】->【相机】\n对%@开启相机的访问权限",@"该APP"];
            // UIAlertViewController(弹框视图)
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:tipMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action_cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action_cancel];
            [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
            return NO;
        }else{
            return  YES;
        }
    } else {
        //相机硬件不可用【一般是模拟器】
        return NO;
    }
}

+ (void)pushToSystemSettingView {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        if (([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

+ (NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght {
    NSString *newStr = originalStr;
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return newStr;
}

// 字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    if (dic) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

// 字符串字典转 字典
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    if (JSONString.length > 0) {
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        return responseJSON;
    }
    return [NSDictionary dictionary];
}

/*** 判断只能输入数字 **/
#define NUMBERS @"0123456789\n"
+ (BOOL)limitIputNumberWithText:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    return YES;
}


#pragma mark - 屏幕截图的几种方式

/**
 *  屏幕截图有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotWithCaptureType:(CaptureType)type
{
    CGSize imageSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.screen == [UIScreen mainScreen]) {
            [window drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
        }
    }
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [statusBar drawViewHierarchyInRect:statusBar.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self saveImage:image WithCaptureType:type];
    
    return image;
}


/**
 *  屏幕截图没有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotNoStatusBarWithCaptureType:(CaptureType)type
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [UIApplication sharedApplication].windows)
    {
        if (window.screen == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width *window.layer.anchorPoint.x, -window.bounds.size.height *window.layer.anchorPoint.y);
            [window.layer renderInContext:context];
            CGContextRestoreGState(context);
        }
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self saveImage:image WithCaptureType:type];
    return image;
    
}

/**
 *  给一个view截图
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageForView:( UIView * _Nonnull )view withCaptureType:(CaptureType)type
{
    CGSize size = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self saveImage:image WithCaptureType:type];
    return image;
    
}

/**
 *  保存image到指定的位置
 *
 *  @param image image
 *  @param type  类型
 */
+ (void)saveImage:(UIImage *)image WithCaptureType:(CaptureType)type
{
    
    NSData *data = UIImagePNGRepresentation(image);
    /**
     *  时间戳
     */
    NSString *time =[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    switch (type) {
        case CaptureTypeSandbox:
        {
            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
        }
            break;
        case CaptureTypePhotes:
        {
            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
            
        }
            break;
        case CaptureTypeBoth:
        {
            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
            [data writeToFile:pathCachesWithFileName([NSString stringWithFormat:@"%@_mainScrren_status.png",time]) atomically:YES];
        }
            break;
        default:
            break;
    }
}

// 指定回调方法
+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
#ifdef DEBUG
    if(error != NULL)
    {
        msg = @"保存图片失败" ;
    } else {
        msg = @"保存图片成功" ;
    }
#endif
}


@end
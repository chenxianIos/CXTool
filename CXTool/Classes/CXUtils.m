//
//  CXUtils.m
//  CXTool
//
//  Created by chenxian on 2019/8/23.
//

#import "CXUtils.h"
#import "CXTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CLLocationManager.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <EventKit/EventKit.h>
#import <CoreTelephony/CTCellularData.h>
#import <HealthKit/HealthKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <PassKit/PassKit.h>
#import <Speech/Speech.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Intents/Intents.h>

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

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
// UIView中的safeAreaInsets如果是刘海屏就会发生变化，普通屏幕safeAreaInsets恒等于UIEdgeInsetsZero
+ (BOOL)isNotchScreen{
    
    if (@available(iOS 11.0, *)) {
        CGFloat safeH =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        
        if (safeH>0) {
            
            return YES;
        }
    }
    
    return NO;
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


+ (void)gotoVC:(NSString *)classString{
    UINavigationController *navigationVC = [self getCurrentVC].navigationController;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    //    遍历导航控制器中的控制器
    
    for (UIViewController *vc in navigationVC.viewControllers) {
        
        [viewControllers addObject:vc];
        
        if ([vc isKindOfClass:NSClassFromString(classString)]) {
            
            break;
            
        }
        
    }
    
    //    把控制器重新添加到导航控制器
    
    [navigationVC setViewControllers:viewControllers animated:YES];
    //    [navigationVC popViewControllerAnimated:YES];
    
}

// iPhone X以上设备iOS版本一定是11.0以上。
+ (BOOL)isIphoneXUp{
    if (@available(iOS 11.0, *)) {
        // 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X以上设备。
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


+ (void)openLocationServiceWithBlock:(ReturnBlock)returnBlock  {
    BOOL isOPen = NO;
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        isOPen = YES;
    }
    if (returnBlock) {
        returnBlock(isOPen);
    }
}
+ (void)openMessageNotificationServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
        if (returnBlock) {
            returnBlock(settings.authorizationStatus == UNAuthorizationStatusAuthorized);
        }
    }];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    returnBlock([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]);
#else
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (returnBlock) {
        returnBlock(type != UIRemoteNotificationTypeNone);
    }
#endif
}
+ (void)openCaptureDeviceServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (returnBlock) {
                returnBlock(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        returnBlock(NO);
    } else {
        returnBlock(YES);
    }
#endif
}
+ (void)openAlbumServiceWithBlock:(ReturnBlock)returnBlock
{
    BOOL isOpen;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    isOpen = YES;
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        isOpen = NO;
    }
#else
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    isOpen = YES;
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        isOpen = NO;
    }
#endif
    if (returnBlock) {
        returnBlock(isOpen);
    }
}
+ (void)openRecordServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    if (permissionStatus == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (returnBlock) {
                returnBlock(granted);
            }
        }];
    } else if (permissionStatus == AVAudioSessionRecordPermissionDenied) {
        returnBlock(NO);
    } else {
        returnBlock(YES);
    }
#endif
}
+ (void)openContactsServiceWithBolck:(ReturnBlock)returnBolck
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CNAuthorizationStatus cnAuthStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (cnAuthStatus == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError *error) {
            if (returnBolck) {
                returnBolck(granted);
            }
        }];
    } else if (cnAuthStatus == CNAuthorizationStatusRestricted || cnAuthStatus == CNAuthorizationStatusDenied) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else {
        if (returnBolck) {
            returnBolck(YES);
        }
    }
#else
    //ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus != kABAuthorizationStatusAuthorized) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"Error: %@", (__bridge NSError *)error);
                    if (returnBolck) {
                        returnBolck(NO);
                    }
                } else {
                    if (returnBolck) {
                        returnBolck(YES);
                    }
                }
            });
        });
    } else {
        if (returnBolck) {
            returnBolck(YES);
        }
    }
#endif
}
+ (void)openPeripheralServiceWithBolck:(ReturnBlock)returnBolck
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    CBPeripheralManagerAuthorizationStatus cbAuthStatus = [CBPeripheralManager authorizationStatus];
    if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusNotDetermined) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusRestricted || cbAuthStatus == CBPeripheralManagerAuthorizationStatusDenied) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else {
        if (returnBolck) {
            returnBolck(YES);
        }
    }
#endif
}
+ (void)openEventServiceWithBolck:(ReturnBlock)returnBolck withType:(EKEntityType)entityType
{
    // EKEntityTypeEvent    代表日历
    // EKEntityTypeReminder 代表备忘
    EKAuthorizationStatus ekAuthStatus = [EKEventStore authorizationStatusForEntityType:entityType];
    if (ekAuthStatus == EKAuthorizationStatusNotDetermined) {
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:entityType completion:^(BOOL granted, NSError *error) {
            if (returnBolck) {
                returnBolck(granted);
            }
        }];
    } else if (ekAuthStatus == EKAuthorizationStatusRestricted || ekAuthStatus == EKAuthorizationStatusDenied) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else {
        if (returnBolck) {
            returnBolck(YES);
        }
    }
}
+ (void)openEventServiceWithBolck:(ReturnBlock)returnBolck
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
        if (state == kCTCellularDataRestrictedStateUnknown || state == kCTCellularDataNotRestricted) {
            if (returnBolck) {
                returnBolck(NO);
            }
        } else {
            if (returnBolck) {
                returnBolck(YES);
            }
        }
    };
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    if (state == kCTCellularDataRestrictedStateUnknown || state == kCTCellularDataNotRestricted) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else {
        if (returnBolck) {
            returnBolck(YES);
        }
    }
#endif
}
+ (void)openHealthServiceWithBolck:(ReturnBlock)returnBolck
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    if (![HKHealthStore isHealthDataAvailable]) {
        if (returnBolck) {
            returnBolck(NO);
        }
    } else {
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        HKObjectType *hkObjectType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
        HKAuthorizationStatus hkAuthStatus = [healthStore authorizationStatusForType:hkObjectType];
        if (hkAuthStatus == HKAuthorizationStatusNotDetermined) {
            // 1. 你创建了一个NSSet对象，里面存有本篇教程中你将需要用到的从Health Stroe中读取的所有的类型：个人特征（血液类型、性别、出生日期）、数据采样信息（身体质量、身高）以及锻炼与健身的信息。
            NSSet <HKObjectType *> * healthKitTypesToRead = [[NSSet alloc] initWithArray:@[[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],[HKObjectType workoutType]]];
            // 2. 你创建了另一个NSSet对象，里面有你需要向Store写入的信息的所有类型（锻炼与健身的信息、BMI、能量消耗、运动距离）
            NSSet <HKSampleType *> * healthKitTypesToWrite = [[NSSet alloc] initWithArray:@[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],[HKObjectType workoutType]]];
            [healthStore requestAuthorizationToShareTypes:healthKitTypesToWrite readTypes:healthKitTypesToRead completion:^(BOOL success, NSError *error) {
                if (returnBolck) {
                    returnBolck(success);
                }
            }];
        } else if (hkAuthStatus == HKAuthorizationStatusSharingDenied) {
            if (returnBolck) {
                returnBolck(NO);
            }
        } else {
            if (returnBolck) {
                returnBolck(YES);
            }
        }
    }
#endif
}
+ (void)openTouchIDServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    LAContext *laContext = [[LAContext alloc] init];
    //localizedFallbackTitle这个设置的使用密码的字体，当text=@""时，按钮将被隐藏
    laContext.localizedFallbackTitle = @"输入密码";
    if (@available(iOS 10.0, *)) {
        laContext.localizedCancelTitle=@"取消";
    }
    NSError *error;
    NSString* result = @"";
    if (@available(iOS 11.0, *)) {
        if (laContext.biometryType == LABiometryTypeTouchID) {
            result = @"需要验证您的Touch ID";
        }else if (laContext.biometryType == LABiometryTypeFaceID){
            result = @"需要验证您的Face ID";
        }
    }
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"恭喜,Touch ID可以使用!");
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                // 识别成功
                if (returnBlock) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        returnBlock(YES);
                    }];
                }
            } else if (error) {
                if (returnBlock) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        returnBlock(NO);
                    }];
                }
                if (error.code == LAErrorAuthenticationFailed) {
                    // 验证失败
                }
                if (error.code == LAErrorUserCancel) {
                    // 用户取消
                }
                if (error.code == LAErrorUserFallback) {
                    // 用户选择输入密码
                }
                if (error.code == LAErrorSystemCancel) {
                    // 系统取消
                }
                if (error.code == LAErrorPasscodeNotSet) {
                    // 密码没有设置
                }
            }
        }];
    } else {
        NSLog(@"设备不支持Touch ID功能,原因:%@",error);
        if (returnBlock) {
            returnBlock(NO);
        }
    }
#endif
}
+ (void)openApplePayServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    NSArray<PKPaymentNetwork> *supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkDiscover];
    if ([PKPaymentAuthorizationViewController canMakePayments] && [PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
        if (returnBlock) {
            returnBlock(YES);
        }
    } else {
        if (returnBlock) {
            returnBlock(NO);
        }
    }
#endif
}
+ (void)openSpeechServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    SFSpeechRecognizerAuthorizationStatus speechAuthStatus = [SFSpeechRecognizer authorizationStatus];
    if (speechAuthStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(YES);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(YES);
                    }
                });
            }
        }];
    } else if (speechAuthStatus == SFSpeechRecognizerAuthorizationStatusAuthorized) {
        if (returnBlock) {
            returnBlock(YES);
        }
    } else{
        if (returnBlock) {
            returnBlock(NO);
        }
    }
#endif
}
+ (void)openMediaPlayerServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_3
    MPMediaLibraryAuthorizationStatus authStatus = [MPMediaLibrary authorizationStatus];
    if (authStatus == MPMediaLibraryAuthorizationStatusNotDetermined) {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(YES);
                    }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(NO);
                    }
                });
            }
        }];
    }else if (authStatus == MPMediaLibraryAuthorizationStatusAuthorized){
        if (returnBlock) {
            returnBlock(YES);
        }
    }else{
        if (returnBlock) {
            returnBlock(NO);
        }
    }
#endif
}
+ (void)openSiriServiceWithBlock:(ReturnBlock)returnBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    INSiriAuthorizationStatus siriAutoStatus = [INPreferences siriAuthorizationStatus];
    if (siriAutoStatus == INSiriAuthorizationStatusNotDetermined) {
        [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
            if (status == INSiriAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(YES);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (returnBlock) {
                        returnBlock(YES);
                    }
                });
            }
        }];
    } else if (siriAutoStatus == INSiriAuthorizationStatusAuthorized) {
        if (returnBlock) {
            returnBlock(YES);
        }
    } else{
        if (returnBlock) {
            returnBlock(NO);
        }
    }
#endif
}

@end

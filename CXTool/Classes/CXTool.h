
//
//  CategorieHelper.h
//  MedicalCustomer
//
//  Created by 陈贤 on 2018/9/7.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#ifndef CXTool_h
#define CXTool_h

#import "CXUtils.h"
#import "NSString+CXBOOL.h"
#import "NSString+CXExtension.h"
#import "NSString+CXDevice.h"
#import "NSString+CXEncrypt.h"
#import "UIButton+ImageTitleStyle.h"
#import "UIButton+CXExpandBtn.h"
#import "UIImage+CXExtension.h"
#import "UISearchBar+textFiled.h"
#import "UIViewController+Dealloc.h"


#pragma mark  **************** 常用宏定义 ****************
// --获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif


// --获取状态栏的高度
#define kSTATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
// --获取导航栏的高度
#define kNAVIGATIONBAR_HEIGHT (STATUS_BAR_HEIGHT + 44)
// --tabbar高
#define kTABBAR_HEIGHT (STATUS_BAR_HEIGHT > 20 ? 83 : 49)
// --iphonex底部安全区域
#define kIPHONEX_SAFE_BOTTOM_MARGIN (IS_iPhoneXLater ? 34.f : 0.f)

// --以6为基准适配宽
#define kWidthToFit(wiDth)  (ceilf( [UIScreen mainScreen].bounds.size.width / 375.0f  * (wiDth) * 2) / 2.0f)

// --常用对象
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kApplication [UIApplication sharedApplication]
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

// --图片快速赋值
#define kImageName(imageName) [UIImage imageNamed:imageName]
// --字符串快速赋值
#define kNSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
// --URL快速赋值
#define kUrl(string)      [NSURL URLWithString:string]

// --随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
// --RGB颜色
#define kRGBColor(r, g, b) kRGBAColor(r, g, b, 1.0)
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// --RGB颜色转换（16进制->10进制）
#define kColorFromRGB(rgbValue) kColorFromRGBA(rgbValue, 1.0)
#define kColorFromRGBA(rgbValue, a) \
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]

// --弱引用/强引用
#define kWeakSelf   kWeakObj(self)
#define kStrongSelf     kStrongObj(self)
#define kWeakObj(type)  __weak typeof(type) weak##type = type;
#define kStrongObj(type)  __strong typeof(type) type = weak##type;

// --可变数组快速懒加载
#define kLazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);
// --类快速懒加载
#define kLazyClass(_view,Class) \
return !(_view) ? (_view) = [[Class alloc]init] : (_view);

// --字体
#define kFONT_SYSTEM_BOLD(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define kFONT_SYSTEM(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define kFONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// --View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
// --View 上半边圆角
#define kViewHalfRadiusUp(View, Radius)\
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:View.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(Radius, Radius)];\
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];\
maskLayer.frame = View.bounds;\
maskLayer.path = maskPath.CGPath;\
View.layer.mask = maskLayer;
// --View 下半边圆角
#define kViewHalfRadiusDown(View, Radius)\
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:View.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(Radius, Radius)];\
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];\
maskLayer.frame = View.bounds;\
maskLayer.path = maskPath.CGPath;\
View.layer.mask = maskLayer;
// --设置 view 圆角和边框
#define kViewRadiusBorder(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// --判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// --判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// --判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// --判断是否为 iPhone 5SE
#define IS_IPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// --判断是否为iPhone 6/6s
#define IS_IPhone6 [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// --判断是否为iPhone 6Plus/6sPlus
#define IS_IPhone6Plus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
// --判断是否为 iPhone X系列
#define IS_iPhoneXLater [CXTool isNotchScreen]
// --判断是否为横屏
#define kIsLandscape ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
// --判断 iOS 8 或更高的系统版本
#define kVERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

// --APP名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
// --APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// --APP build版本
#define kAppBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]\
// --获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// --自定义高效率的 NSLog
#ifdef DEBUG
#define kLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define kLog(...)
#endif

// --判断是不是iOS系统，如果是iOS系统在真机和模拟器输出都是YES
#if TARGET_OS_IPHONE
#endif
#if (TARGET_IPHONE_SIMULATOR)
/** 在模拟器的情况下 *///
#else
/** 在真机情况下 *///
#endif

// --获取temp
#define kPathTemp NSTemporaryDirectory()
// --获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// --获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// --载入Nib文件时候用到
#define kNIB_NAMED(class) ([UINib nibWithNibName:NSStringFromClass(class) bundle:nil])
// --加载本名的Nib文件
#define kNIB_SELF ([[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject])

#endif /* CXTool_h */

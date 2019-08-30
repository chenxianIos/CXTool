//
//  UIImage+Extension.h

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (CXExtension)

/** 根据size和color，返回一张图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 根据字符串生产二维码 */
+ (UIImage*)imageWithQRCode:(NSString*)code;

/** 根据颜色生产图片 */
+ (UIImage *)imageWithColor:(UIColor *)aColor;

/** 添加水印 */
+ (UIImage *)image:(UIImage *)img addLogo:(UIImage *)logo;

//UIView转UIImage
+ (UIImage*)convertViewToImage:(UIView*)view;

// 压缩图片按照大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;

// 压缩图片按照比例
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio;

//压缩图片到指定大小(单位KB)
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

//** 创建一张实时模糊效果 View (毛玻璃效果) */
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;


// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊
// CIDiscBlur    --->  环形卷积模糊
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置
// CIMotionBlur  --->  运动模糊, 用于模拟相机移动拍摄时的扫尾效果
//** 对图片进行模糊处理 */
+ (UIImage *)blurWithOriginalImage:(UIImage *)image
                          blurName:(NSString *)name
                            radius:(NSInteger)radius;

// 怀旧 --> CIPhotoEffectInstant      单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir         褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal        冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer     铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
//** 对图片进行滤镜处理 */
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

@end

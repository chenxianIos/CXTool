

#import <UIKit/UIKit.h>

#define  Font(f) [UIFont systemFontOfSize:(f)]

typedef void (^ButtonBlock)(UIButton *button);
@interface UIButton (CXExpandBtn)

@property(nonatomic,strong)NSString *buttonId;//标识
@property(nonatomic,copy)ButtonBlock block;//添加点击事件
@property (nonatomic,assign) UIEdgeInsets hitTestEdgeInsets;//点击区域，默认为（0，0，0，0）; 负的为扩大

//添加block
-(void)addClickBlock:(ButtonBlock)block;

@end

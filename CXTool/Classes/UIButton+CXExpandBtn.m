

#import "UIButton+CXExpandBtn.h"
#import <objc/runtime.h>

static const NSString *KEY_ButtonId = @"buttonId";

static const NSString *KEY_ButtonBlock = @"buttonBlock";


static const NSString *KEY_HitTestEdgeInsets = @"hitTestEdgeInsets";

@implementation UIButton (CXExpandBtn)


//扩大点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden)
    {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}


//添加点击事件-
-(void)addClickBlock:(ButtonBlock)block
{
    
    self.block = block;
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonAction:(UIButton *)button
{
    self.block(button);
}

#pragma mark--- getter setter--
//分类中不能直接使用setter和getter、需要使用运行时
- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HitTestEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets
{
    NSValue *value = objc_getAssociatedObject(self, &KEY_HitTestEdgeInsets);
    if(value)
    {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }
    else
    {
        return UIEdgeInsetsZero;
    }
}
-(void)setButtonId:(NSString *)buttonId{
    objc_setAssociatedObject(self, &KEY_ButtonId, buttonId, OBJC_ASSOCIATION_RETAIN);
}
-(NSString *)buttonId{
    return objc_getAssociatedObject(self, &KEY_ButtonId);
    
}
-(void)setBlock:(ButtonBlock)block{
    objc_setAssociatedObject(self, &KEY_ButtonBlock, block, OBJC_ASSOCIATION_RETAIN);
}
-(ButtonBlock)block{
    return objc_getAssociatedObject(self, &KEY_ButtonBlock);
}
@end

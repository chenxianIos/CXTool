//
//  UISearchBar+textFiled.m
//  MedicalInternet
//
//  Created by 陈贤 on 2018/3/20.
//  Copyright © 2018年 nbawater1234. All rights reserved.
//

#import "UISearchBar+textFiled.h"

@implementation UISearchBar (textFiled)


//下面两个方法是UISearchBar分类代码
- (void)cx_setTextColor:(UIColor *)textColor {
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)cx_setTextFont:(CGFloat)font {
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = [UIFont systemFontOfSize:font];
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:font]];
    }
}

- (void)cx_setCancelButtonTitle:(NSString *)title {
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

@end

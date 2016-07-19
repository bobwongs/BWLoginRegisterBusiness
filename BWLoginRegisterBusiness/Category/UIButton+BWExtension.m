//
//  UIButton+BWExtension.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "UIButton+BWExtension.h"

@implementation UIButton (BWExtension)

+ (UIButton *)bw_buttonDefaultStyleWithTitle:(NSString *)titleButton target:(id)target action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:titleButton forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end

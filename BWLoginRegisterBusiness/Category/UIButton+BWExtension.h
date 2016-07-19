//
//  UIButton+BWExtension.h
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BWExtension)

+ (UIButton *)bw_buttonDefaultStyleWithTitle:(NSString *)titleButton target:(id)target action:(SEL)selector;

@end

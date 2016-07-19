//
//  UITextField+BWExtension.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "UITextField+BWExtension.h"

@implementation UITextField (BWExtension)

+ (UITextField *)bw_textFieldDefaultStyle
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleBezel;
    
    return textField;
}

@end

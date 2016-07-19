//
//  BWHomeViewController.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWHomeViewController.h"

@implementation BWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
    
    [self setUI];
}

- (void)buttonActionLogout:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [BWGlobalInstance logoutToClearData];
}

- (void)setUI
{
    UIButton *buttonLogout = [UIButton bw_buttonDefaultStyleWithTitle:@"Logout" target:self action:@selector(buttonActionLogout:)];
    [self.view addSubview:buttonLogout];
    
    [buttonLogout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(44);
    }];
}

@end

//
//  BWLoginViewController.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLoginViewController.h"
#import "BWHomeViewController.h"
#import "BWRegisterViewController.h"
#import "BWForgetPasswordViewController.h"
#import "BWHelpViewController.h"
#import "BWLoginedAccountViewController.h"

@interface BWLoginViewController ()

@property (nonatomic, strong) UITextField *tfAccount;
@property (nonatomic, strong) UITextField *tfPassword;

@property (nonatomic, strong) UIButton *buttonLogin;
@property (nonatomic, strong) UIButton *buttonRegister;
@property (nonatomic, strong) UIButton *buttonForgetPassoword;
@property (nonatomic, strong) UIButton *buttonHelp;

@end

@implementation BWLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    
    [self setUI];
    
    // 延后执行，避免ViewController的View还没显示就做转场动画会报警告
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (BWGlobalInstance.isLogin) {
            // 用token去进行网络请求，成功进行跳转
            [self presentHomeViewController];
        }
    });
}

#pragma mark - Action

- (void)buttonActSelectAccount:(UIButton *)sender
{
    BWLoginedAccountViewController *vcLoginedAccount = [[BWLoginedAccountViewController alloc] init];
    vcLoginedAccount.blockSelectedAccount = ^(NSString *account) {
        _tfAccount.text = account;
    };
    [self.navigationController pushViewController:vcLoginedAccount animated:YES];
}

- (void)buttonActLogin:(UIButton *)sender
{
    NSString *account = _tfAccount.text;
    NSString *password = _tfPassword.text;
    if (!account || account.length == 0 || !password || password.length == 0) {
        NSLog(@"Account or Password is Not Correct!");
        return ;
    }
    
    [BWGlobalInstance setLogin:YES token:@"token" account:account password:password];
    BWGlobalInstance.userType = kUserTypeA;
    [self presentHomeViewController];
    
    if (BWGlobalIsUserTypeA) {
        NSLog(@"current user type is A");
    }
    else if (BWGlobalIsUserTypeB) {
        NSLog(@"current user type is B");
    }
}

- (void)buttonActRegister:(UIButton *)sender
{
    BWRegisterViewController *vcRegister = [[BWRegisterViewController alloc] init];
    [self.navigationController pushViewController:vcRegister animated:YES];
}

- (void)buttonActForgetPassword:(UIButton *)sender
{
    BWForgetPasswordViewController *vcForgetPassword = [[BWForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:vcForgetPassword animated:YES];
}

- (void)buttonActHelp:(UIButton *)sender
{
    BWHelpViewController *vcHelp = [[BWHelpViewController alloc] init];
    [self.navigationController pushViewController:vcHelp animated:YES];
}

#pragma mark - Private Method

- (void)presentHomeViewController
{
    BWHomeViewController *vcHome = [[BWHomeViewController alloc] init];
    [self presentViewController:vcHome animated:YES completion:nil];
}

- (void)setUI
{
    UITextField *tfAccount = [UITextField bw_textFieldDefaultStyle];
    self.tfAccount = tfAccount;
    tfAccount.placeholder = @"Account";
    [self.view addSubview:tfAccount];
    UIButton *btnSelectAccount = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btnSelectAccount.frame = CGRectMake(0, 0, 30, 30);
    [btnSelectAccount addTarget:self action:@selector(buttonActSelectAccount:) forControlEvents:UIControlEventTouchUpInside];
    [tfAccount setRightView:btnSelectAccount];
    [tfAccount setRightViewMode:UITextFieldViewModeAlways];
    
    UITextField *tfPassword = [UITextField bw_textFieldDefaultStyle];
    self.tfPassword = tfPassword;
    tfPassword.placeholder = @"Password";
    [self.view addSubview:tfPassword];
    
    UIButton *buttonLogin = [UIButton bw_buttonDefaultStyleWithTitle:@"Login" target:self action:@selector(buttonActLogin:)];
    self.buttonLogin = buttonLogin;
    [self.view addSubview:buttonLogin];
    UIButton *buttonRegister = [UIButton bw_buttonDefaultStyleWithTitle:@"Register" target:self action:@selector(buttonActRegister:)];
    self.buttonRegister = buttonRegister;
    [self.view addSubview:buttonRegister];
    UIButton *buttonForgetPassword = [UIButton bw_buttonDefaultStyleWithTitle:@"Forget Password" target:self action:@selector(buttonActForgetPassword:)];
    self.buttonForgetPassoword = buttonForgetPassword;
    [self.view addSubview:buttonForgetPassword];
    UIButton *buttonHelp = [UIButton bw_buttonDefaultStyleWithTitle:@"Help" target:self action:@selector(buttonActHelp:)];
    self.buttonHelp = buttonHelp;
    [self.view addSubview:buttonHelp];
    
    
    NSArray *arrayViews = @[tfAccount, tfPassword, buttonLogin, buttonRegister, buttonForgetPassword, buttonHelp];
    for (NSInteger index = 0; index < arrayViews.count; index++) {
        UIView *view = arrayViews[index];
        CGFloat h = 44;
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(150 + index * (h + 20));
            make.height.mas_equalTo(h);
        }];
    }
}

@end

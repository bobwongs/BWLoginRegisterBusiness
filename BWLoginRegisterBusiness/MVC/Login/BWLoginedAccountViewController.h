//
//  BWLoginedAccountViewController.h
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/11.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWBaseViewController.h"

@interface BWLoginedAccountViewController : BWBaseViewController

@property (nonatomic, copy) void(^blockSelectedAccount)(NSString *account);  //!< Selected Account

@end

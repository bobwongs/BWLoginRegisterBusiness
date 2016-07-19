//
//  BWKeyChain.h
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/8.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end

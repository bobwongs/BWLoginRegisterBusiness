//
//  BWGlobal.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWGlobal.h"
#import "BWKeyChain.h"

#define NSUserDefaultsStandard [NSUserDefaults standardUserDefaults]
NSString *const kAccount = @"kAccount";
NSString *const kPassword = @"kPassword";

@implementation BWGlobal

NSString *const kUserTypeA = @"UserTypeA";
NSString *const kUserTypeB = @"UserTypeB";
NSString *const kIsLogin = @"IsLogin";
NSString *const kToken = @"Token";

+ (instancetype)sharedInstance
{
    static BWGlobal *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[super alloc] init];
        
        [singleton initData];
    });
    
    return singleton;
}

- (void)initData
{
    _isLogin = [NSUserDefaultsStandard boolForKey:kIsLogin];
    _token = [NSUserDefaultsStandard objectForKey:kToken];
    NSLog(@"%@", self);
}

/*
 缓存策略
 非用户隐私性数据选择NSUserDefaults；优点：便捷快速，缺点：不够安全；
 用户隐私性数据选择KeyChain；优点：安全；缺点：不论有没卸载应用，缓存数据如果不移除会一直存在（待验证）
 */

- (void)setLogin:(BOOL)isLogin
           token:(NSString *)token
         account:(NSString *)account
        password:(NSString *)password
{
    self.isLogin = isLogin;
    self.token = token;
    self.account = account;
    self.password = password;
    
    [BWUserCacheManager setCacheWithUserAccount:account cacheData:[NSString stringWithFormat:@"%@'s cache", _account]];
    
    NSLog(@"%@", self);
}

- (void)logoutToClearData
{
    self.isLogin = NO;
    
    NSUserDefaults *userDefaults = NSUserDefaultsStandard;
    [userDefaults removeObjectForKey:kToken];
    [BWKeyChain delete:kPassword];
    
    _token = nil;
    _account = nil;
    _password = nil;
    _userType = nil;
    _modelBase = nil;
    
    NSLog(@"%@", self);
}


- (void)setIsLogin:(BOOL)isLogin
{
    [NSUserDefaultsStandard setBool:isLogin forKey:kIsLogin];
    _isLogin = isLogin;
}

- (void)setToken:(NSString *)token
{
    [NSUserDefaultsStandard setObject:token forKey:kToken];
    _token = token;
}

- (void)setAccount:(NSString *)account
{
    [BWKeyChain save:_account data:kAccount];
    _account = account;
}

- (void)setPassword:(NSString *)password
{
    // 写入KeyChain
    [BWKeyChain save:kPassword data:password];
    _password = password;
}


- (NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"isLogin:%d, token:%@, cache token:%@,  account:%@, password:%@, cache password:%@, userType:%@, modelBase:%@", _isLogin, _token, [NSUserDefaultsStandard objectForKey:kToken], _account,  _password, [BWKeyChain load:kPassword],_userType, _modelBase];
    
    return description;
}

@end


@implementation BWUserBaseModel

@end


@implementation BWUserCacheManager

NSString *const kUserAccountCacheDataArray = @"kUserAccountCacheDataArray";

+ (void)setCacheWithUserAccount:(NSString *)account cacheData:(NSString *)cacheData
{
    NSUserDefaults *userDefaults = NSUserDefaultsStandard;
    NSMutableDictionary *dictAccounts = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:kUserAccountCacheDataArray]];
    [dictAccounts setObject:cacheData forKey:account];
    
    [userDefaults setObject:dictAccounts forKey:kUserAccountCacheDataArray];
}

+ (void)deleteCacehWithUserAccount:(NSString *)account
{
    NSMutableDictionary *dictAccounts = [[self class] getCacheUserDatas];
    [dictAccounts removeObjectForKey:account];
    [NSUserDefaultsStandard setObject:dictAccounts forKey:kUserAccountCacheDataArray];
}

+ (NSMutableDictionary *)getCacheUserDatas
{
    NSMutableDictionary *dictAccounts = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaultsStandard objectForKey:kUserAccountCacheDataArray]];
    return dictAccounts;
}

+ (NSArray *)getCacheAccounts
{
    return [[[self class] getCacheUserDatas] allKeys];
}

@end

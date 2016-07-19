//
//  BWGlobal.h
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/6.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BWUserBaseModel;

#define BWGlobalInstance [BWGlobal sharedInstance]
#define BWGlobalIsUserTypeA [BWGlobalInstance.userType isEqualToString:kUserTypeA]
#define BWGlobalIsUserTypeB [BWGlobalInstance.userType isEqualToString:kUserTypeB]

extern NSString *const kAccount;
extern NSString *const kPassword;
extern NSString *const kUserTypeA;
extern NSString *const kUserTypeB;

@interface BWGlobal : NSObject

@property (nonatomic, assign) BOOL isLogin;  //!< 登录态，记录是否已经登录
@property (nonatomic, strong) NSString *token;  //!< 用户token
@property (nonatomic, strong) NSString *userType;  //!< 用户类型

@property (nonatomic, strong) NSString *account;  //!< 登录用户的Account，不放在modelBase上，因为这样方便对account进行缓存
@property (nonatomic, strong) NSString *password;  //!< 用户密码，Keychain进行存储

@property (nonatomic, strong) NSString *userCacheData;  //!< 用户缓存数据，不随退出登录而消失，会随删除登录账户列表时消失

@property (nonatomic, strong) BWUserBaseModel *modelBase;  //!< 用户基础数据，方便供需要用到的地方进行使用，如果数据量不大，则可以直接作为Global的成员变量，一般最好分一下，方便区分和管理

+ (instancetype)sharedInstance;

- (void)setLogin:(BOOL)isLogin
           token:(NSString *)token
         account:(NSString *)account
        password:(NSString *)password;  //!< 设置登录态、token、account、password

- (void)logoutToClearData;  //!< 退出登录进行数据清除和设置登录态为NO

@end


@interface BWUserBaseModel : NSObject

@end


@interface BWUserCacheManager : NSObject

+ (void)setCacheWithUserAccount:(NSString *)account cacheData:(NSString *)cacheData;
+ (void)deleteCacehWithUserAccount:(NSString *)account;
+ (NSMutableDictionary *)getCacheUserDatas;
+ (NSArray *)getCacheAccounts;

@end

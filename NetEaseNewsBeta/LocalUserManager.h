//
//  LocalUserManager.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface LocalUserManager : NSObject
@property (nonatomic,strong)UserModel *user;
@property (nonatomic,assign)BOOL isLogin;

+ (id)sharedLocalUserManager;

- (BOOL)writeUserData;
- (void)readUserData;
@end


//
//  LocalUserManager.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "LocalUserManager.h"

@implementation LocalUserManager
static LocalUserManager *localUserManager;

+ (id)sharedLocalUserManager{
    if (!localUserManager) {
        localUserManager = [[LocalUserManager alloc] init];
        localUserManager.user = [[UserModel alloc] init];
        localUserManager.isLogin  =NO;
    }
    return localUserManager;
}


- (BOOL)writeUserData{
    
    BOOL isSave = NO;
    
    isSave = [NSKeyedArchiver archiveRootObject:self.user toFile:LOCAL_USER_PATH];
    return isSave;
}
- (void)readUserData{
    NSString *path = LOCAL_USER_PATH;
    
    UserModel *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:LOCAL_USER_PATH];
    
    if (!temp) {
        self.user = [[UserModel alloc] init];
    }else{
        //user.password = @"123456";
        self.user = temp;
    }
}
@end

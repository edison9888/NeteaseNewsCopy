//
//  UserLoginVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-24.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonParse.h"
#import "LocalUserManager.h"
#import "UserRegisterVC.h"

@interface UserLoginVC : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *userPwd;

@property(nonatomic,strong)UIButton *btnRegister;
@property(nonatomic,strong)UIButton *btnLogin;
@property(nonatomic,strong)LocalUserManager *localUser;
@end

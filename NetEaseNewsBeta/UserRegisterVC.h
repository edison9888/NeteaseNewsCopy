//
//  UserRegisterVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "JsonParse.h"
#import "UserDetailVC.h"
#import "LocalUserManager.h"

@interface UserRegisterVC : UIViewController
    
@property(nonatomic,strong)UITextField *txtMail; //邮件
@property(nonatomic,strong)UITextField *txtPassword; //密码
@property(nonatomic,strong)UITextField *txtMobilePhone; //手机
@property(nonatomic,strong)UIButton *btnRegister; //注册按钮

@end

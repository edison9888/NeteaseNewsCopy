//
//  RightSliderController.h
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-10.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginVC.h"
#import "LocalUserManager.h"
#import "UserDetailVC.h"
#import "NewsPostVC.h"
#import "NewsCollectionVC.h"
#import "OfflineNewsManager.h"

@interface RightSliderController : UIViewController

@property(nonatomic,strong)UIButton *btnLogin;
@property(nonatomic,strong)LocalUserManager *localUser;
@property(nonatomic,strong)OfflineNewsManager *offlineNews;

@property(nonatomic,strong)UIButton *btnCollection;
@property(nonatomic,strong)UIButton *btnOffline;
@property(nonatomic,strong)UIButton *btnMyPost;
@property(nonatomic,strong)UIButton *btnSetting;
@end

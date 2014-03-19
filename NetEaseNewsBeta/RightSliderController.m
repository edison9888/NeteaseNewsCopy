//
//  RightSliderController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-10.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "RightSliderController.h"

@interface RightSliderController ()

@end

@implementation RightSliderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localUser = [LocalUserManager sharedLocalUserManager];
    [_localUser readUserData];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgView.image = [UIImage imageNamed:@"sidebar_bg"];
    [self.view addSubview:bgView];
    
    //登出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginout:) name:@"loginout" object:nil];
    //登录通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logined:) name:@"logined" object:nil];
    //功能按钮
    [self setLoginBtn];
    //收藏
    _btnCollection = [[UIButton alloc] initWithFrame:CGRectMake(185, 200, 100, 30)];
    [_btnCollection setImage:[UIImage imageNamed:@"contenttoolbar_hd_fav_light"] forState:UIControlStateNormal];
    [_btnCollection setTitle:@"收藏" forState:UIControlStateNormal];
    [_btnCollection addTarget:self action:@selector(btnCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCollection];
    //离线
    _btnOffline = [[UIButton alloc] initWithFrame:CGRectMake(185, 240, 100, 30)];
    [_btnOffline setImage:[UIImage imageNamed:@"plugin_icon_offline"] forState:UIControlStateNormal];
    [_btnOffline setTitle:@"离线" forState:UIControlStateNormal];
    [_btnOffline addTarget:self action:@selector(btnOfflineAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnOffline];
    //我的爆料
    _btnMyPost = [[UIButton alloc] initWithFrame:CGRectMake(185, 280, 100, 30)];
    [_btnMyPost setImage:[UIImage imageNamed:@"plugin_icon_mailbox"] forState:UIControlStateNormal];
    [_btnMyPost setTitle:@"爆料" forState:UIControlStateNormal];
    [_btnMyPost addTarget:self action:@selector(toPostVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnMyPost];
    //设置
    _btnSetting = [[UIButton alloc] initWithFrame:CGRectMake(185, 320, 100, 30)];
    [_btnSetting setImage:[UIImage imageNamed:@"plugin_icon_setting"] forState:UIControlStateNormal];
    [_btnSetting setTitle:@"设置" forState:UIControlStateNormal];
    [self.view addSubview:_btnSetting];
}

- (void)setLoginBtn{
    //用户按钮
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(185, 150, 90, 15)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0f];
    self.btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(185, 50, 90, 90)];
    [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"logined"] forState:UIControlStateSelected];
    [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"usercenter_hd_avatar_default"] forState:UIControlStateNormal];
    if (_localUser.isLogin) {
        [self.btnLogin setSelected:YES];
        self.btnLogin.layer.masksToBounds = YES;
        self.btnLogin.layer.cornerRadius = 45;
        label.text = _localUser.user.nickName;
        [self.btnLogin addTarget:self action:@selector(btnUserDetail) forControlEvents:UIControlEventTouchUpInside];
    }else{
        label.text = @"点击登陆";
        [self.btnLogin setSelected:NO];
        [self.btnLogin addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.btnLogin];
    [self.view addSubview:label];
}

- (void)btnUserDetail{
    NSLog(@"to userdetail");
    UserDetailVC *userDetail = [[UserDetailVC alloc] init];
    [self.navigationController pushViewController:userDetail animated:YES];
}
- (void)btnLoginAction{
    UserLoginVC *login = [[UserLoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}
- (void)btnOfflineAction{
    NSLog(@"downloading offline news");
    _offlineNews = [OfflineNewsManager sharedOfflineNewsManager];
    [_offlineNews writeOfflineNews];
    
}

- (void)toPostVC{
    NewsPostVC *newsPost = [[NewsPostVC alloc] init];
    [self.navigationController pushViewController:newsPost animated:YES];
}
- (void)btnCollectionAction{
    NewsCollectionVC *vc = [[NewsCollectionVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)logined:(NSNotification *)notification{
    [self setLoginBtn];
}
- (void)loginout:(NSNotification *)notification{
    [self setLoginBtn];
}
@end

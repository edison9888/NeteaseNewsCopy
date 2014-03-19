//
//  UserLoginVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-24.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "UserLoginVC.h"

@interface UserLoginVC ()

@end

@implementation UserLoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"用户登录";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    
    //username
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(20, 104, 280, 30)];
    _userName.delegate = self;
    
    _userName.placeholder = @"请输入帐号";
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *name = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 26, 26)];
    name.image = [UIImage imageNamed:@"login_username_icon"];
    _userName.leftView = name;
    
    //userpwd
    _userPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 149, 280, 30)];
    _userPwd.delegate = self;
    
    _userPwd.placeholder = @"请输入密码";
    _userPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userPwd.leftViewMode = UITextFieldViewModeAlways;
    _userPwd.secureTextEntry = YES;
    UIImageView *pwd = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 26, 26)];
    pwd.image = [UIImage imageNamed:@"login_password_icon"];
    _userPwd.leftView = pwd;
    
    //btn register
    _btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 30)];
    [_btnRegister setBackgroundImage:[[UIImage imageNamed:@"loginview_regbutton"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_btnRegister addTarget:self action:@selector(btnRegisterClicked) forControlEvents:UIControlEventTouchUpInside];
    //btn login
	_btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(140, 200, 160, 30)];
    _btnLogin.enabled = NO;
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [_btnLogin setBackgroundImage:[[UIImage imageNamed:@"loginview_loginbutton"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];
    [_btnLogin addTarget:self action:@selector(btnLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_userName];
    [self.view addSubview:_userPwd];
    [self.view addSubview:_btnRegister];
    [self.view addSubview:_btnLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//注册按钮
- (void)btnRegisterClicked{
    NSLog(@"register clicked");
//    UserModel *newUser = [UserModel testUserWithMail:_userName.text andPassword:_userPwd.text andMobilephone:234212312];
//    NSString *jsonContent = [HttpRequest addStaffWithUser:newUser];
//    newUser = [JsonParse parseAddUserByJson:jsonContent];
    UserRegisterVC *vc = [[UserRegisterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//登陆按钮
- (void)btnLoginClicked{
    NSLog(@"login clicked");
    NSString *jsonContent = [HttpRequest loginWithEmail:_userName.text AndPassword:_userPwd.text];
    UserModel *user = [JsonParse parseLoginResponseByJson:jsonContent];
    if (user){
        NSLog(@"登录成功");
        _localUser = [LocalUserManager sharedLocalUserManager];
        _localUser.user = user;
        _localUser.user.password = _userPwd.text;
        _localUser.isLogin = YES;
        [_localUser writeUserData];
        NSNotification *notic = [NSNotification notificationWithName:@"logined" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notic];
        [self.navigationController.navigationBar setHidden:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _localUser.isLogin = NO;
        NSLog(@"登录失败");
    }
    
    
}


- (void)backBtnAction{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (_userName.text.length>0&&_userPwd.text.length>0) {
        _btnLogin.enabled = YES;
    }else{
        _btnLogin.enabled = NO;
    }
    
    return YES;
}
@end

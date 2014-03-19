//
//  UserRegisterVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "UserRegisterVC.h"

@interface UserRegisterVC ()

@end

@implementation UserRegisterVC

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
    self.title = @"用户注册";
	self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    
    //邮件
    _txtMail = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 240, 30)];
    _txtMail.placeholder = @"请输入注册邮箱";
    _txtMail.borderStyle = UITextBorderStyleLine;
    _txtMail.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_txtMail];
    //手机
    _txtMobilePhone = [[UITextField alloc] initWithFrame:CGRectMake(40, 140, 240, 30)];
    _txtMobilePhone.placeholder = @"请输入注册手机";
    _txtMobilePhone.borderStyle = UITextBorderStyleLine;
    _txtMobilePhone.keyboardType = UIKeyboardTypePhonePad;
    _txtMobilePhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_txtMobilePhone];
    //密码
    _txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(40, 180, 240, 30)];
    _txtPassword.placeholder = @"请输入密码";
    _txtPassword.borderStyle = UITextBorderStyleLine;
    _txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_txtPassword];
    //注册按钮
    _btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(60, 250, 200, 40)];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_btnRegister setBackgroundColor:[UIColor redColor]];
    [_btnRegister addTarget:self action:@selector(btnRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnRegister];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)btnRegisterAction{
    UserModel *newUser = [UserModel testUserWithMail:_txtMail.text andPassword:_txtPassword.text andMobilephone:[_txtMobilePhone.text intValue]];
    newUser.qq = [_txtMobilePhone.text intValue];
    NSString *jsonContent = [HttpRequest addStaffWithUser:newUser];
    newUser = [JsonParse parseAddUserByJson:jsonContent];
    if (newUser) {
        LocalUserManager *local = [LocalUserManager sharedLocalUserManager];
        local.user = newUser;
        local.isLogin = YES;
        [local writeUserData];
        NSNotification *notic = [NSNotification notificationWithName:@"logined" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notic];
        
        UserDetailVC *vc = [[UserDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"注册失败");
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end

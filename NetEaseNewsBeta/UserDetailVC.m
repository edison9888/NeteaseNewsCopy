//
//  UserDetailVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "UserDetailVC.h"

@interface UserDetailVC ()

@end

@implementation UserDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用户详情";
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    
    _localUser = [LocalUserManager sharedLocalUserManager];
    NSString *json = [UserModel jsonWithUser:_localUser.user];
    _dic = [json JSONValue];
    _arrKeys = [_dic allKeys];
    
    
    _tableInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableInfo.dataSource = self;
    _tableInfo.delegate = self;
    
    [self setHeaderView];
    [self setFooterView];
    [self.view addSubview:_tableInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)setHeaderView{
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)];
    head.image = [UIImage imageNamed:@"logined"];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 20)];
    name.text = _localUser.user.nickName;
    [_header addSubview:head];
    [_header addSubview:name];
    _tableInfo.tableHeaderView = _header;
}
- (void)setFooterView{
    _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIButton *loginOut = [[UIButton alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
    [loginOut setTitle:@"登出" forState:UIControlStateNormal];
    [loginOut addTarget:self action:@selector(btnLoginOutAction) forControlEvents:UIControlEventTouchUpInside];
    loginOut.backgroundColor = [UIColor redColor];
    loginOut.layer.masksToBounds = YES;
    loginOut.layer.cornerRadius = 5;
    [_footer addSubview:loginOut];
    _tableInfo.tableFooterView = _footer;
}

- (void)backBtnAction{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)btnLoginOutAction{
    NSString *jsonContent = [HttpRequest loginWithEmail:@"" AndPassword:@""];
    UserModel *user = [JsonParse parseLoginResponseByJson:jsonContent];
    if (user){
        NSLog(@"登录成功");
    }else{
        _localUser.isLogin = NO;
        _localUser.user = user;
        [_localUser writeUserData];
        NSNotification *notic = [NSNotification notificationWithName:@"loginout" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notic];
        NSLog(@"登出");
        [self.navigationController.navigationBar setHidden:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UserDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //设置数据
    NSString *key = [_arrKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = key;
    id value = [_dic objectForKey:key];
    if ([[value class] isSubclassOfClass:[NSString class]]) {
        cell.textLabel.text = value;
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",value];
    }
    
    
    return cell;
}


#pragma mark -UITableViewDelegate Methods

@end

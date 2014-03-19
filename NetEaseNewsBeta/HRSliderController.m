//
//  HRSliderController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "HRSliderController.h"
#import <QuartzCore/QuartzCore.h>

#import "LeftSliderController.h"
#import "RightSliderController.h"
#import "ClassModel.h"
#import "HRViewController.h"
#import "LocalUserManager.h"

#define RCloseDuration 0.3f
#define ROpenDuration 0.4f
#define RContentScale 0.83f
#define RContentOffset 180.0f
#define RJudgeOffset 100.0f

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};

@interface HRSliderController ()
{
    UIView *_mainContentView;
    UIView *_leftSideView;
    UIView *_rightSideView;
    
    NSMutableDictionary *_controllersDict;

    UITapGestureRecognizer *_tapGestureRec;
    UIPanGestureRecognizer *_panGestureRec;
    LocalUserManager *_localUser;
}

@end

static HRSliderController *sharedSC;
@implementation HRSliderController

+ (id)sharedSliderController
{
    return sharedSC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localUser = [LocalUserManager sharedLocalUserManager];
    [_localUser readUserData];
    //设置通知，网络改变时触发
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNetwork:) name:kReachabilityChangedNotification object:nil];
    //创建Reachability对象
    self.netCheck=[Reachability reachabilityForInternetConnection];
    //开始监听网络
    [self.netCheck startNotifier];
    //获得当前网络
    NetworkStatus status=[self.netCheck currentReachabilityStatus];
    
    [self checkNetwork:status];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSC = self;
    });
    _controllersDict = [NSMutableDictionary dictionary];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    
    [self initSubviews];
    
    [self initChildControllers];
    
    [self showContentControllerWithModel:[ClassModel classModelWithTitle:@"新闻" className:@"NewsVC" contentText:@"新闻视图内容" andImageName:@"sidebar_nav_news"]];
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:_panGestureRec];
    
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logined:) name:@"logined" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginout:) name:@"loginout" object:nil];
}

#pragma mark -
#pragma mark Intialize Method

- (void)initSubviews
{
    UIView *rv = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:rv];
    _rightSideView = rv;
    
    UIView *lv = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:lv];
    _leftSideView = lv;
    
    UIView *mv = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mv];
    _mainContentView = mv;
}

- (void)initChildControllers
{
    LeftSliderController *leftSC = [[LeftSliderController alloc] init];
    [self addChildViewController:leftSC];
    [_leftSideView addSubview:leftSC.view];
    
    
    RightSliderController *rightSC = [[RightSliderController alloc] init];
    [self addChildViewController:rightSC];
    
    [_rightSideView addSubview:rightSC.view];
}

#pragma mark -
#pragma mark Actions

- (void)showContentControllerWithModel:(ClassModel *)model
{
    [self closeSideBar];
    
    UIViewController *controller = _controllersDict[model.className];
    
        Class c = NSClassFromString(model.className);
        HRViewController *vc = [[c alloc] init];
        controller = [[UINavigationController alloc] initWithRootViewController:vc];
        
        //vc.contentText = model.contentText;
        UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 22)];
        UIImageView *titleImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 22)];
        titleImg.image=[UIImage imageNamed:@"navbar_netease"];
        UILabel *titleText=[[UILabel alloc] initWithFrame:CGRectMake(48, 0, 45, 22)];
        titleText.text=model.title;
        titleText.font=[UIFont systemFontOfSize:20];
        titleText.textColor=[UIColor whiteColor];
        [titleView addSubview:titleImg];
        [titleView addSubview:titleText];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.bounds = CGRectMake(0, 0, 44, 44);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"top_navigation_menuicon.png"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"top_navigation_menuicon_highlighted.png"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.bounds = CGRectMake(0, 0, 44, 44);
        if (_localUser.isLogin) {
            rightBtn.bounds = CGRectMake(0, 0, 30, 30);
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"logined"] forState:UIControlStateNormal];
            rightBtn.layer.masksToBounds = YES;
            rightBtn.layer.cornerRadius = 15;
            rightBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            rightBtn.layer.borderWidth = 1;
        }else{
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"top_navigation_infoicon"] forState:UIControlStateNormal];
        }
        [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
        vc.navigationController.navigationBar.barStyle=UIBarStyleBlack;
        vc.navigationItem.rightBarButtonItem = rightItem;
        vc.navigationItem.leftBarButtonItem = leftItem;
        vc.navigationItem.titleView = titleView;
        vc.view.backgroundColor=[UIColor whiteColor];
        [_controllersDict setObject:controller forKey:model.className];
    
    
    
    if (_mainContentView.subviews.count > 0)
    {
        UIView *view = [_mainContentView.subviews firstObject];
        [view removeFromSuperview];
    }
    
    controller.view.frame = _mainContentView.frame;
    [_mainContentView addSubview:controller.view];
}

- (void)leftItemClick
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    [self.view sendSubviewToBack:_rightSideView];
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    
    [UIView animateWithDuration:ROpenDuration
                     animations:^{
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                     }];
}

- (void)rightItemClick
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    
    [self.view sendSubviewToBack:_leftSideView];
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    
    [UIView animateWithDuration:ROpenDuration
                     animations:^{
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                     }];
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView animateWithDuration:RCloseDuration
                     animations:^{
                         _mainContentView.transform = oriT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                     }];
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;
        transX = transX + currentTranslateX;
        
        CGFloat sca;
        if (transX > 0)
        {
            [self.view sendSubviewToBack:_rightSideView];
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            
            if (_mainContentView.frame.origin.x < RContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/RContentOffset) * (1-RContentScale);
            }
            else
            {
                sca = RContentScale;
            }
        }
        else    //transX < 0
        {
            [self.view sendSubviewToBack:_leftSideView];
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            
            if (_mainContentView.frame.origin.x > -RContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/RContentOffset) * (1-RContentScale);
            }
            else
            {
                sca = RContentScale;
            }
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(1.0, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        
        _mainContentView.transform = conT;
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > RJudgeOffset)
        {
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            return;
        }
        if (finalX < -RJudgeOffset)
        {
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = NO;
        }
    }
}

#pragma mark -
#pragma mark Private

- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -RContentOffset;
            break;
        case RMoveDirectionRight:
            translateX = RContentOffset;
            break;
        default:
            break;
    }
    
    NSLog(@"%.2f",translateX);
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(RContentScale, RContentScale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor redColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.8f;
}
#pragma mark - 网络检测

//判断当前是什么网络
-(void)checkNetwork:(NetworkStatus)status{
    
    //没有网的时候进行提示
    if (status==kNotReachable) {
        
        [self messageBox:@"没有网络"];
        
    }else if (status==kReachableViaWWAN){
        
        [self messageBox:@"正在使用2G/3G网络"];
        //用户登录
        NSString *str =[HttpRequest loginWithEmail:_localUser.user.mail AndPassword:_localUser.user.password];
        if ([JsonParse parseLoginResponseByJson:str]) {
            _localUser.isLogin = YES;
        }
        
    }else if (status==kReachableViaWiFi){
        
        [self messageBox:@"正在使用wifi网络"];
        //用户登录
        NSString *str =[HttpRequest loginWithEmail:_localUser.user.mail AndPassword:_localUser.user.password];
        if ([JsonParse parseLoginResponseByJson:str]) {
            _localUser.isLogin = YES;
        }
        
    }
    
}

-(void)messageBox:(NSString *)string{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}

//网络改变时调用
-(void)changeNetwork:(NSNotification *)notification{
    
    //获得当前网络
    NetworkStatus status=[self.netCheck currentReachabilityStatus];
    
    [self checkNetwork:status];
    
}

- (void)logined:(NSNotification *)notification{
    [self showContentControllerWithModel:[ClassModel classModelWithTitle:@"新闻" className:@"NewsVC" contentText:@"新闻视图内容" andImageName:@"sidebar_nav_news"]];
}

- (void)loginout:(NSNotification *)notification{
    [self showContentControllerWithModel:[ClassModel classModelWithTitle:@"新闻" className:@"NewsVC" contentText:@"新闻视图内容" andImageName:@"sidebar_nav_news"]];
}
@end

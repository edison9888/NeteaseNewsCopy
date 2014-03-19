//
//  HRViewController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "HRViewController.h"

@interface HRViewController ()

@end

@implementation HRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.contentText;
    label.font = [UIFont systemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}

@end

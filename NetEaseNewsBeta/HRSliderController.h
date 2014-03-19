//
//  HRSliderController.h
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class ClassModel;

@interface HRSliderController : UIViewController

@property(nonatomic,strong)Reachability *netCheck;

+ (id)sharedSliderController;

- (void)showContentControllerWithModel:(ClassModel *)model;

@end

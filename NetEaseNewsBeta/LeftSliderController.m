//
//  LeftSliderController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "LeftSliderController.h"

#import "ClassModel.h"
#import "HRButton.h"
#import "HRSliderController.h"

#define RButtonWidth 180
#define RButtonHeight 400/6

@interface LeftSliderController ()
{
    NSArray *_modelList;
}

@end

@implementation LeftSliderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backView.image = [UIImage imageNamed:@"sidebar_bg"];
    [self.view addSubview:backView];
    
    [self initialModelsAndButtons];
}

- (void)initialModelsAndButtons
{
    ClassModel *news = [ClassModel classModelWithTitle:@"新闻" className:@"NewsVC" contentText:@"新闻视图内容" andImageName:@"sidebar_nav_news"];
    ClassModel *pic = [ClassModel classModelWithTitle:@"图片" className:@"PicViewController" contentText:@"图片视图内容" andImageName:@"sidebar_nav_photo"];
    ClassModel *video = [ClassModel classModelWithTitle:@"视频" className:@"VideoViewController" contentText:@"视频视图内容" andImageName:@"sidebar_nav_reading"];
    ClassModel *comment = [ClassModel classModelWithTitle:@"跟帖" className:@"CommentViewController" contentText:@"跟帖视图内容" andImageName:@"sidebar_nav_comment"];
    ClassModel *vote = [ClassModel classModelWithTitle:@"爆料" className:@"PostNewsViewController" contentText:@"爆料视图内容" andImageName:@"sidebar_nav_vote"];
    
    _modelList = @[news, pic, video, comment, vote];
    
    for (NSInteger i = 0; i < _modelList.count; i++)
    {
        HRButton *cmButton = [self buttonWithClassModel:_modelList[i]];
        cmButton.frame = CGRectMake(0, 40+i*RButtonHeight, RButtonWidth, RButtonHeight);
        [self.view addSubview:cmButton];
    }
}

//private
- (HRButton *)buttonWithClassModel:(ClassModel *)model
{
    HRButton *btn = [HRButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:model.imageName];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitle:model.title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:21.0f]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chooseTheModel:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = [_modelList indexOfObject:model];
    
    return btn;
}

//action
- (void)chooseTheModel:(UIButton *)sender
{
    ClassModel *model = _modelList[sender.tag];
    NSLog(@"选择了类目:%@", model.title);
    
    [[HRSliderController sharedSliderController] showContentControllerWithModel:model];
}

@end

//
//  AddCommentView.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "AddCommentView.h"

@implementation AddCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _txtComment = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 250, 38)];
        _txtComment.background = [[UIImage imageNamed:@"toolbar_light_comment"] stretchableImageWithLeftCapWidth:100 topCapHeight:0];
        _txtComment.returnKeyType = UIReturnKeySend;
        _txtComment.delegate = self;
        _btnCollection = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 40, 40)];
        [_btnCollection setBackgroundImage:[UIImage imageNamed:@"contenttoolbar_hd_fav_light"] forState:UIControlStateNormal];
        [_btnCollection setBackgroundImage:[UIImage imageNamed:@"contenttoolbar_hd_fav_selected_light"] forState:UIControlStateSelected];
        [_btnCollection addTarget:self action:@selector(btnCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_txtComment];
        [self addSubview:_btnCollection];
    }
    return self;
}

- (IBAction)btnCollectionAction:(id)sender{
    if ([self respondsToSelector:@selector(btnCollectionMethod)]) {
        [self.delegate btnCollectionMethod];
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([self respondsToSelector:@selector(beginTextComment)]){
        [self.delegate beginTextComment];
    }
    _txtComment.background = [[UIImage imageNamed:@"channel_sidebar_button_selected"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if([self respondsToSelector:@selector(endTextComment)]){
        [self.delegate endTextComment];
    }
    _txtComment.background = [[UIImage imageNamed:@"toolbar_light_comment"] stretchableImageWithLeftCapWidth:100 topCapHeight:0];
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"comment send");
    if([self respondsToSelector:@selector(btnSendMethod)]){
        [self.delegate btnSendMethod];
    }
    return YES;
}




#pragma mark -AddCommentProtcol
//发送评论
- (void)btnSendMethod{
    NSLog(@"comment send");
}
//收藏新闻
- (void)btnCollectionMethod{
    NSLog(@"collection clicked");
}
//
- (void)beginTextComment{
    
}
- (void)endTextComment{
    
}
@end

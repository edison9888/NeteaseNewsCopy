//
//  AddCommentView.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
@protocol AddCommentProtcol <NSObject>
@required
//发送评论
- (void)btnSendMethod;
//收藏新闻
- (void)btnCollectionMethod;
//
- (void)beginTextComment;
- (void)endTextComment;
@end


#import <UIKit/UIKit.h>
#import "JsonParse.h"

@interface AddCommentView : UIView <UITextFieldDelegate>
@property(nonatomic,strong)UITextField *txtComment;
@property(nonatomic,strong)UIButton *btnCollection;
@property(nonatomic,strong)CommentModel *comment;

@property(nonatomic,weak)id<AddCommentProtcol> delegate;
@end


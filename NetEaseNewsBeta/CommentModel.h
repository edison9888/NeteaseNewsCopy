//
//  CommentModel.h
//  NetEaseNewsBeta
//  评论类
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "UserModel.h"

@interface CommentModel : NSObject
@property(nonatomic,strong)NSString *ip;//用户IP
@property(nonatomic,strong)NSString *nickName;//用户昵称
@property(nonatomic,strong)NSString *longitude;//GPS经度
@property(nonatomic,strong)NSString *latitude;//GPS纬度

@property(nonatomic,strong)NSString *publishedTime;//评论时间
@property(nonatomic,strong)NSString *content;//评论内容
@property(nonatomic,assign)int drId;//评论编号
@property(nonatomic,assign)int stfId;//用户编号
@property(nonatomic,assign)int contentId;//文章id

///用户评论
+ (CommentModel *)commentByUser:(UserModel *)user AndMsg:(NSString *)msg;

///json评论
+ (NSString *)jsonWithComment:(CommentModel *)comment;
@end

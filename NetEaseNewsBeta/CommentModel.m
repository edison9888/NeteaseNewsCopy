//
//  CommentModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
///用户评论
+ (CommentModel *)commentByUser:(UserModel *)user AndMsg:(NSString *)msg{
    CommentModel *newComment = [[CommentModel alloc] init];
    newComment.stfId = user.stfId;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    newComment.publishedTime = strDate;
    newComment.content = msg;
    
    return newComment;
}
///json评论
+ (NSString *)jsonWithComment:(CommentModel *)comment{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:comment.contentId],@"contentid",[NSNumber numberWithInt:comment.stfId],@"StfId",comment.publishedTime,@"Published",comment.content,@"content", nil];
    
    return [dic JSONRepresentation];
}

@end

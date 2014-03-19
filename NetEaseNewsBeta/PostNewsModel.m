//
//  PostNewsModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "PostNewsModel.h"

@implementation PostNewsModel

- (id) init{
    
    self.comments = 0;
    self.modelid = 11;
    self.playtime = 0;
    self.catid = 1;
    self.topicid = 123;
    self.video = @"luyucheng.mp4";
    
    
    return self;
    
}
+ (NSString *)jsonPostNews:(PostNewsModel *)postnews{
    NSMutableArray *arrImg = [[NSMutableArray alloc] init];
    for (ImageModel *obj in postnews.imageList) {
        [arrImg addObject:[obj imageModelToDic]];
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:postnews.title,@"title",[NSNumber numberWithInt:postnews.modelid],@"modelid",[NSNumber numberWithInt:postnews.catid],@"catid",postnews.description,@"description",postnews.source,@"Source",postnews.content,@"Content",postnews.video,@"Video",[NSNumber numberWithInt:postnews.playtime],@"Playtime",[NSString stringWithFormat:@"%d",postnews.topicid],@"topicid",postnews.published,@"published",postnews.thumb,@"thumb",[NSNumber numberWithInt:postnews.comments],@"comments",arrImg,@"Imagelist" ,nil];
    
    return [dic JSONRepresentation];
}
@end

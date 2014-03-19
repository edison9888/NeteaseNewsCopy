//
//  NewsModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
- (void)setNewsWithDictionary:(NSDictionary *)dic{
    self.contentId = [[dic objectForKey:@"ContentId"] intValue];
    self.modelid = [[dic objectForKey:@"Modelid"] intValue];
    self.catid = [[dic objectForKey:@"Catid"] intValue];
    self.title = [dic objectForKey:@"Title"];
    self.description = [dic objectForKey:@"Description"];
    self.thumb = [NSString stringWithFormat:@"%@/UpLoad/%@",NEWS_HOST,[dic objectForKey:@"Thumb"]];
    self.published = [dic objectForKey:@"Published"];
    self.content = [dic objectForKey:@"Content"];
    self.source = [dic objectForKey:@"Source"];
    self.video = [NSString stringWithFormat:@"%@/Video/%@",NEWS_HOST,[dic objectForKey:@"Video"]];
    self.playtime = [[dic objectForKey:@"Playtime"] intValue];
    self.topicid = [[dic objectForKey:@"Topicid"] intValue];
    self.comments = [[dic objectForKey:@"Comments"] intValue];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.thumb forKey:@"thumb"];
    [aCoder encodeObject:self.published forKey:@"published"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.video forKey:@"video"];
    
    [aCoder encodeInt:self.contentId forKey:@"contentId"];
    [aCoder encodeInt:self.modelid forKey:@"modelid"];
    [aCoder encodeInt:self.catid forKey:@"catid"];
    [aCoder encodeInt:self.playtime forKey:@"playtime"];
    [aCoder encodeInt:self.topicid forKey:@"topicid"];
    [aCoder encodeInt:self.comments forKey:@"comments"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.description = [aDecoder decodeObjectForKey:@"description"];
    self.thumb = [aDecoder decodeObjectForKey:@"thumb"];
    self.published = [aDecoder decodeObjectForKey:@"published"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.source = [aDecoder decodeObjectForKey:@"source"];
    self.video = [aDecoder decodeObjectForKey:@"video"];
    
    self.modelid = [aDecoder decodeIntForKey:@"modelid"];
    self.catid = [aDecoder decodeIntForKey:@"catid"];
    self.contentId = [aDecoder decodeIntForKey:@"contentId"];
    self.playtime = [aDecoder decodeIntForKey:@"playtime"];
    self.topicid = [aDecoder decodeIntForKey:@"topicid"];
    self.comments = [aDecoder decodeIntForKey:@"comments"];
    return self;
}

@end

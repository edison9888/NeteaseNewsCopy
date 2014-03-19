//
//  NewsTypeModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsTypeModel.h"

@implementation NewsTypeModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.thumb forKey:@"thumb"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.modelid forKey:@"modelid"];
    [aCoder encodeInt:self.catid forKey:@"catid"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self.thumb = [aDecoder decodeObjectForKey:@"thumb"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.modelid = [aDecoder decodeIntForKey:@"modelid"];
    self.catid = [aDecoder decodeIntForKey:@"catid"];
    return self;
}
@end

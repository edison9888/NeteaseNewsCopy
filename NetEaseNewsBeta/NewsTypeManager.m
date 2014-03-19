//
//  NewsTypeManager.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsTypeManager.h"

@implementation NewsTypeManager
static NewsTypeManager *newsTypes;
+ (id)sharedNewsTypes{
    if (!newsTypes) {
        newsTypes = [[NewsTypeManager alloc] init];
        newsTypes.arrTypes = [[NSMutableArray alloc] init];
    }
    return newsTypes;
}
    
- (BOOL)writeNewsTypes{
    BOOL isSave = NO;
    
    isSave = [NSKeyedArchiver archiveRootObject:self.arrTypes toFile:NEWS_TYPES_PATH];
    
    return isSave;
}
- (void)readNewsTypes{
    NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:NEWS_TYPES_PATH];
    
    if (!temp) {
        self.arrTypes = [[NSMutableArray alloc] init];
    }else{
        self.arrTypes = temp;
    }
}
@end

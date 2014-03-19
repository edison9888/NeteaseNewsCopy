//
//  OfflineNewsManager.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "OfflineNewsManager.h"

@implementation OfflineNewsManager
static OfflineNewsManager *offlineNews;

+ (id)sharedOfflineNewsManager{
    if (!offlineNews) {
        offlineNews = [[OfflineNewsManager alloc] init];
        offlineNews.dicNews = [[NSMutableDictionary alloc] init];
    }
    return offlineNews;
}

- (void)downloadOfflineNews{
    _newsTypes = [NewsTypeManager sharedNewsTypes];
    _dicNews = [[NSMutableDictionary alloc] init];
    
    int allcount = 0;
    int curcount = 0;
    for (NewsTypeModel *type in _newsTypes.arrTypes) {
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        NSArray *arrNews = [JsonParse parseNewsListByJson:[HttpRequest getNewsListByCatid:type.catid AndPagesize:10 AndPage:1]];
        int count = (int)arrNews.count;
        allcount +=count;
        
        for (int i=0 ; i<count; i++) {
            NewsModel *temp = [arrNews objectAtIndex:i];
            TextNewsModel *news = [JsonParse parseTextNewsByJson:[HttpRequest getNewsByContentId:temp.contentId]];
            curcount +=1;
            NSLog(@"%d/%d",curcount,allcount);
            [arrTemp addObject:news];
        }
        [_dicNews setObject:arrTemp forKey:type.name];
    }
    
    
    
}

- (BOOL)writeOfflineNews{
    
    BOOL isSave = NO;
    [self downloadOfflineNews];
    isSave = [NSKeyedArchiver archiveRootObject:self.dicNews toFile:OFFLINE_NEWS_PATH];
    return isSave;
    
}

- (BOOL)readOfflineNews{
    BOOL isRead = NO;
    self.dicNews = [NSKeyedUnarchiver unarchiveObjectWithFile:OFFLINE_NEWS_PATH];
    if (self.dicNews) {
        isRead = YES;
    }
    NSArray *arr = [self.dicNews objectForKey:@"手机"];
    TextNewsModel *test = [arr objectAtIndex:1];
    return isRead;
}

@end

//
//  NewsCollectionManager.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsCollectionManager.h"

@implementation NewsCollectionManager
    static NewsCollectionManager *collectionNews;

+ (id)sharedCollectionNews{
    
    if (!collectionNews) {
        collectionNews = [[NewsCollectionManager alloc] init];
        collectionNews.arrCollectionNews = [[NSMutableArray alloc] init];
    }
    return collectionNews;
}
    
- (BOOL)writeCollectionNews{
    BOOL isSave = NO;
    isSave = [NSKeyedArchiver archiveRootObject:self.arrCollectionNews toFile:COLLECTION_NEWS_PATH];
    return isSave;
}
- (void)readCollectionNews{
    
    NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:COLLECTION_NEWS_PATH];
    if (temp) {
        self.arrCollectionNews = temp;
    }
}

@end

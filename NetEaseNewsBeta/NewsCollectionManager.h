//
//  NewsCollectionManager.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@interface NewsCollectionManager : NSObject
    
@property(nonatomic,strong)NSMutableArray *arrCollectionNews;

+ (id)sharedCollectionNews;

- (BOOL)writeCollectionNews;
- (void)readCollectionNews;
@end

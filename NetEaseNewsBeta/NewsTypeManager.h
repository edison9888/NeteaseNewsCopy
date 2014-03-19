//
//  NewsTypeManager.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsTypeModel.h"

@interface NewsTypeManager : NewsTypeModel

@property(nonatomic,strong)NSMutableArray *arrTypes;
    
+ (id)sharedNewsTypes;


- (BOOL)writeNewsTypes;
- (void)readNewsTypes;
@end

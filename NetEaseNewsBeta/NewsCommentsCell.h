//
//  NewsCommentsCell.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "CommentModel.h"
@interface NewsCommentsCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userhead;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *userContent;

- (void)setCellWithComment:(CommentModel *)comment;

@end

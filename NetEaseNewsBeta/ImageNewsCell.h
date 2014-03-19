//
//  ImageNewsCell.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgNewsModel.h"

@interface ImageNewsCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imgThumb;
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbComments;

- (void)setCellWithImgnews:(ImgNewsModel *)imgNews;
@end

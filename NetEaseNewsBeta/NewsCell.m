//
//  NewsCell.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgThumb=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 50)];
        self.imgThumb.image=[UIImage imageNamed:@"contentview_imagebg_logo"];
        self.lbTitle=[[UILabel alloc] initWithFrame:CGRectMake(85, 5, 220, 20)];
        self.lbTitle.font=TITLE_FONT;
        self.lbDescription=[[UILabel alloc] initWithFrame:CGRectMake(85, 20, 200, 40)];
        self.lbDescription.font=DESCRIPTION_FONT;
        self.lbDescription.textColor=[UIColor grayColor];
        self.lbDescription.numberOfLines = 2;
        self.lbComments=[[UILabel alloc] initWithFrame:CGRectMake(270, 48, 50, 10)];
        self.lbComments.font=COMMENTS_FONT;
        self.lbComments.textAlignment=NSTextAlignmentRight;
        
        [self addSubview:self.imgThumb];
        [self addSubview:self.lbDescription];
        [self addSubview:self.lbComments];
        [self addSubview:self.lbTitle];
    }
    return self;
}

- (void)setNews:(NewsModel *)news{
    if (self.news!=news) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            NSURL *imgUrl=[NSURL URLWithString:news.thumb];
            NSData *data=[NSData dataWithContentsOfURL:imgUrl];
            if (data!=nil) {
                _imgThumb.image=[UIImage imageWithData:data];
                
            }
        });
        self.lbTitle.text=news.title;
        self.lbDescription.text=news.description;
        self.lbComments.text= [NSString stringWithFormat:@"%d跟贴",news.comments];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

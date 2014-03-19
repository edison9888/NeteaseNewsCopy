//
//  ImageNewsCell.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//  cell height 100

#import "ImageNewsCell.h"

@implementation ImageNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgThumb = [[UIImageView alloc] initWithFrame:CGRectMake(20, 2, 280, 128)];
        _imgThumb.image = [UIImage imageNamed:@"contentview_imagebg_logo"];
        
        _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 200, 18)];
        _lbComments = [[UILabel alloc] initWithFrame:CGRectMake(230, 130, 50, 18)];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.bounds];
        bg.image = [[UIImage imageNamed:@"channel_sidebar_button"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        self.backgroundView = bg;
        [self addSubview:_imgThumb];
        [self addSubview:_lbTitle];
        [self addSubview:_lbComments];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setCellWithImgnews:(ImgNewsModel *)imgNews{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        NSURL *imgUrl=[NSURL URLWithString:imgNews.thumb];
        NSData *data=[NSData dataWithContentsOfURL:imgUrl];
        if (data!=nil) {
            _imgThumb.image=[UIImage imageWithData:data];
        }
    });
    _lbTitle.text = imgNews.title;
    _lbComments.text = [NSString stringWithFormat:@"%d跟贴",imgNews.comments];
}

@end

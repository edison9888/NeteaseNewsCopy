//
//  NewsCommentsCell.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsCommentsCell.h"

@implementation NewsCommentsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _userhead = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        
        //用户名
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 200, 30)];
        //内容
        _userContent = [[UILabel alloc] init];
        //发帖时间
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:10];
        _time.textColor = [UIColor grayColor];
        
        
        
        [self addSubview:_userhead];
        [self addSubview:_userName];
        [self addSubview:_userContent];
        [self addSubview:_time];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithComment:(CommentModel *)comment{
    _userhead.image = [UIImage imageNamed:@"login_username_icon"];
    if ([comment.nickName length]==0) {
        _userName.text = @"匿名用户";
    }else{
    _userName.text = comment.nickName;
    }
    
   
    
    CGRect contentF = [comment.content boundingRectWithSize:CGSizeMake(300, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName] context:nil];
    
    
    _userContent.text = comment.content;
    _userContent.font = [UIFont systemFontOfSize:18];
    _userContent.frame = CGRectMake(10, 40, 300, contentF.size.height);
    _userContent.numberOfLines = contentF.size.height/18;
    
    _time.text = comment.publishedTime;
    _time.frame = CGRectMake(200, 45+contentF.size.height, 120, 10);
    self.frame = CGRectMake(0, 0, 320, 55+contentF.size.height) ;
    
}

@end

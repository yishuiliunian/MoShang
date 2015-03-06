//
//  MSCommentCell.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCommentCell.h"
#import <DZProgramDefines.h>
#import "MSGlobal.h"
@interface MSCommentCell ()
@property (nonatomic, strong , readonly) UIImageView* avaterImageView;
@property (nonatomic, strong, readonly) UILabel* nickLabel;
@property (nonatomic, strong, readonly) MSBadgeContentView* badgeContentView;
@property (nonatomic, strong, readonly) UILabel* timeLabel;
@end
@implementation MSCommentCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return self;
    }
    INIT_SUBVIEW_UILabel(self.contentView, _nickLabel);
    INIT_SUBVIEW_UILabel(self.contentView, _timeLabel);
    INIT_SUBVIEW_UIImageView(self.contentView, _avaterImageView);
    INIT_SUBVIEW(self.contentView, MSBadgeContentView, _badgeContentView);
    
    MS_Decorate_ImageView_Head(_avaterImageView);
    self.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.backgroundColor = [UIColor whiteColor];
    return self;
}
- (void) setComment:(MSComment *)comment
{
    if (_comment != comment) {
        _comment = comment;
        _nickLabel.text = @"xxxx";
        
        
    }
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = CGSizeMake(60, 60);
    CGFloat space = 10;
    CGFloat itemSpace = 5;
    self.contentView.frame = CGRectMake(space, 5, CGRectGetWidth(self.bounds) - space*2, CGRectGetHeight(self.bounds) - 10);
    CGFloat maxWidth = CGRectGetWidth(self.contentView.frame) - space*2;
    _avaterImageView.frame = CGRectMake(space, space, size.width, size.height);
    
    CGFloat timeWidth = [_timeLabel.text sizeWithFont:_timeLabel.font constrainedToSize:CGSizeMake(1000, 10000) lineBreakMode:NSLineBreakByClipping].width;
    _nickLabel.frame = CGRectMake(CGRectGetMaxX(_avaterImageView.frame) + itemSpace, space, maxWidth - itemSpace - timeWidth, size.height/2);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_nickLabel.frame) + itemSpace, CGRectGetMinY(_nickLabel.frame), timeWidth, size.height/2);
    _badgeContentView.frame = CGRectMake(CGRectGetMaxX(_avaterImageView.frame) + itemSpace, CGRectGetMaxY(_nickLabel.frame), maxWidth - itemSpace - CGRectGetMaxX(_avaterImageView.frame), size.height/2);
}

@end

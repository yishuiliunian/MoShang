//
//  MSMessageCell.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMessageCell.h"
#import "MSLayoutEngine.h"
#import "MSGlobal.h"
#import "MSLayoutEngine.h"
#import <UIImageView+Haneke.h>

@implementation MSMessageCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return self;
    }
    INIT_SUBVIEW(self.contentView, UIImageView, _avarterImageView);
    INIT_SUBVIEW(self.contentView, UILabel, _lastTextLabel);
    INIT_SUBVIEW(self.contentView, UILabel, _lastTimeLabel);
    INIT_SUBVIEW(self.contentView, UILabel, _nickNameLabel);
    _avarterImageView.hnk_cacheFormat = HNKCreateCacheFormatWithSize(CGSizeMake(44, 44), @"message_varatr");
    _avarterImageView.layer.masksToBounds = YES;
    return self;
}

- (void) setMessageHistory:(MSMessageHistoryModel *)messageHistory
{
    if (_messageHistory != messageHistory) {
        _messageHistory = messageHistory;
        _nickNameLabel.text = _messageHistory.toUser.nickName;
        _lastTimeLabel.text = [messageHistory.updateDate toReadString];
        _lastTextLabel.text = _messageHistory.lastMessage;
        [_avarterImageView hnk_setImageFromURL:[NSURL URLWithString:_messageHistory.toUser.avarterURL]];
    }
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat avarterHeight = CGRectGetHeight(self.bounds) - MSDefaultCellHeightSpace*2;
    _avarterImageView.frame = CGRectMake(MSDefaultCellSpace, MSDefaultCellHeightSpace, avarterHeight, avarterHeight);
    _avarterImageView.layer.cornerRadius = CGRectGetHeight(_avarterImageView.frame)/2;
    
    CGSize size = [_lastTimeLabel.text sizeWithFont:_lastTimeLabel.font constrainedToSize:CGSizeMake(10000, 15)];
    
    CGFloat middle = CGRectGetHeight(self.bounds) / 2;
    CGFloat nickHeight = 20;
    CGFloat nickStartY = middle - 20;
    
    _lastTimeLabel.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - MSDefaultCellSpace - size.width, nickStartY, size.width, nickHeight);
    
    _nickNameLabel.frame = CGRectMake(CGRectGetMaxX(_avarterImageView.frame)+5, nickStartY, CGRectGetMinX(_lastTimeLabel.frame) - CGRectGetMaxX(_avarterImageView.frame) - 10, nickHeight);
    _lastTextLabel.frame = CGRectMake(CGRectGetMaxX(_avarterImageView.frame)+5, middle, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(_avarterImageView.frame) - MSDefaultCellSpace, nickHeight);
    
}
@end

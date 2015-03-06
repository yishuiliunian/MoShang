//
//  MSCardItemCell.m
//  MoShang
//
//  Created by stonedong on 15/3/5.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCardItemCell.h"

@implementation MSCardItemCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return self;
    }
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}
@end

//
//  MSFeedDetailView.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedDetailView.h"
#import "MSBadgeContentView.h"
#import <DZProgramDefines.h>
#import "MSGlobal.h"
@interface MSFeedDetailView()
@end
@implementation MSFeedDetailView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    INIT_SELF_SUBVIEW(MSBadgeContentView, _badgeContentView);
    INIT_SELF_SUBVIEW_UILabel(_nickLabel);
    INIT_SELF_SUBVIEW_UIImageView(_avarterImageView);
    INIT_SELF_SUBVIEW(MSFeedFuctionView, _functionView);
    INIT_SELF_SUBVIEW_UILabel(_contentLabel);
    
    _contentLabel.numberOfLines = 0;
    
    MS_Decorate_Label_NickName(_nickLabel);
    _avarterImageView.layer.masksToBounds = YES;
    _avarterImageView.hnk_cacheFormat = MSFormatHeadLittle;
    
    _avarterImageView.image = MSHeadFemale;
    _photosViewController = [[MSAvarterCollectionViewController alloc] initWithAvarters:nil itemSize:CGSizeMake(100, 100)];
    [self addSubview:_photosViewController.collectionView];
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = 10;
    CGFloat itemSpace = 5;
    CGSize avaterSize = CGSizeMake(60, 60);
    
    _avarterImageView.frame = CGRectMake(space, space, avaterSize.width, avaterSize.height);
    _avarterImageView.layer.cornerRadius = avaterSize.width/2;
 
    CGFloat nickStartX = CGRectGetMaxX(_avarterImageView.frame) + itemSpace;
    CGFloat maxNickWidth = CGRectGetWidth(self.bounds) - space - nickStartX;
    
    _nickLabel.frame = CGRectMake(nickStartX, space, maxNickWidth, avaterSize.height/2);
    _badgeContentView.frame = CGRectMake(nickStartX, CGRectGetMaxY(_nickLabel.frame), maxNickWidth, avaterSize.height/2);
    
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - space*2;
    CGSize size = [_contentLabel.text sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(maxWidth, 100000) lineBreakMode:NSLineBreakByClipping];
    _contentLabel.frame = CGRectMake(space, CGRectGetMaxY(_avarterImageView.frame) + itemSpace, maxWidth, size.height);
    
    _photosViewController.view.frame = CGRectMake(space, CGRectGetMaxY(_contentLabel.frame)+itemSpace, maxWidth, 100);
    _functionView.frame = CGRectMake(space, CGRectGetMaxY(_photosViewController.view.frame), maxWidth, 30);
}

- (CGFloat) estamitHeight
{
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - 10*2;
    CGSize size = [_contentLabel.text sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(maxWidth, 100000) lineBreakMode:NSLineBreakByClipping];
    return 100 + 60 + 30 + 20 + size.height;
}

@end

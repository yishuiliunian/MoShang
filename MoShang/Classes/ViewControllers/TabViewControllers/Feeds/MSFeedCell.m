//
//  MSFeedCell.m
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedCell.h"
#import "MSLayoutEngine.h"
#import <DZProgramDefines.h>
#import "MSGlobal.h"
#import "MSFeed.h"
#import <UIImageView+Haneke.h>
#import <HexColor.h>
#import "MSLeftImageButton.h"
#import <TTTAttributedLabel.h>
#import <DZImageCache.h>
#import "MSSetLikeReq.h"
#import "MSSyncCenter.h"
#import "MSTipsPool.h"
#import "MSFeedFuctionView.h"
@interface MSFeedCell() <MSRequestUIDelegate>
@property (nonatomic, strong) UIImageView* headImageView;
@property (nonatomic, strong) UIImageView* backgroudImageView;
@property (nonatomic, strong) UILabel* nickNameLabel;
@property (nonatomic, strong) UILabel* detailFeedLabel;
@property (nonatomic, strong) UIView* functionsBackgroundView;
@property (nonatomic, strong) UIView* detailTextBackgroudView;
@property (nonatomic, strong) MSFeedFuctionView* functionView;
@end
@implementation MSFeedCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return self;
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    INIT_SUBVIEW(self.contentView, UIImageView, _backgroudImageView);
    INIT_SUBVIEW(self.contentView, UIImageView, _headImageView);
    INIT_SUBVIEW(self.contentView, UIView, _detailTextBackgroudView);
    INIT_SUBVIEW(self.contentView, UILabel, _nickNameLabel);
    INIT_SUBVIEW(self.contentView, UILabel, _detailFeedLabel);
    INIT_SUBVIEW(_backgroudImageView, UIView, _functionsBackgroundView);

    _functionsBackgroundView.backgroundColor = [UIColor whiteColor];
    _detailFeedLabel.numberOfLines = 0;
    self.selectedBackgroundView = nil;
    //
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _backgroudImageView.backgroundColor = [UIColor lightGrayColor];
    _backgroudImageView.layer.cornerRadius = 5;
    _backgroudImageView.layer.masksToBounds = YES;
    //
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"cellHead"];
    if (!format) {
        format  = [[HNKCacheFormat alloc] initWithName:@"cellHead"];
        format.size = CGSizeMake(MSFeedHeadImageSizeWidth, MSFeedHeadImageSizeWidth);
        format.scaleMode = HNKScaleModeAspectFill;
        format.compressionQuality = 0.5;
        format.diskCapacity = 10*1024*1024;
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        [[HNKCache sharedCache] registerFormat:format];
    }
    _headImageView.hnk_cacheFormat = format;
    _headImageView.layer.cornerRadius = MSFeedHeadImageSizeWidth/2;
    _headImageView.layer.masksToBounds = YES;
    
    //
    
    HNKCacheFormat* backgroundFormat = [HNKCache sharedCache].formats[@"backgourd_feed"];
    if (!backgroundFormat) {
        backgroundFormat  = [[HNKCacheFormat alloc] initWithName:@"backgourd_feed"];
        backgroundFormat.size = CGSizeMake(MSFeedHeadImageSizeWidth, MSFeedHeadImageSizeWidth);
        backgroundFormat.scaleMode = HNKScaleModeAspectFill;
        backgroundFormat.compressionQuality = 0.5;
        backgroundFormat.diskCapacity = 100*1024*1024;
        backgroundFormat.preloadPolicy = HNKPreloadPolicyLastSession;
        [[HNKCache sharedCache] registerFormat:backgroundFormat];
    }
    _backgroudImageView.hnk_cacheFormat = backgroundFormat;
    
    //
    _nickNameLabel.textColor = [UIColor whiteColor];
    //
    _detailFeedLabel.textColor = [UIColor whiteColor];
    //
    _detailTextBackgroudView.backgroundColor = [UIColor blackColor];
    _detailTextBackgroudView.alpha = 0.5;
    //

    _headImageView.image = DZCachedImageByName(@"default_avater_man.png");
    
    INIT_SUBVIEW(self.contentView, MSFeedFuctionView, _functionView);
    [_functionView.pinglunButton addTarget:self action:@selector(likeIt) forControlEvents:UIControlEventTouchUpInside];
    //h
    [_functionView.liaoliaoButton addTarget:self action:@selector(begainTalk) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}
- (void) begainTalk
{
    if ([self.delegate respondsToSelector:@selector(feedCell:didTapLiaoLiaoBtn:)]) {
        [self.delegate feedCell:self didTapLiaoLiaoBtn:self.feed];
    }
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    _backgroudImageView.image = nil;
    _headImageView.image = nil;
}
- (void) likeIt
{
    MSSetLikeReq* likeReq = [MSSetLikeReq new];
    likeReq.feedid = NUM_TO_STRING(_feed.recordid);
    likeReq.bLike = YES;
    likeReq.uidelegate = self;
    [MSDefaultSyncCenter performRequest:likeReq];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    [MSDefaultTipsPool showError:error];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    self.feed.likecount = [@(self.feed.n_likecount+1) stringValue];
    [_functionView.pinglunButton setTitle:self.feed.likecount forState:UIControlStateNormal];
}

- (void) layouts
{
    MSLineVerticalLayout* layout = [MSLineVerticalLayout new];
    layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void) setFeed:(MSFeed *)feed
{
    if (_feed != feed) {
        _feed = feed;
        _nickNameLabel.text = feed.nick;
        _detailFeedLabel.text = feed.content;
        _detailFeedLabel.font = feed.layoutItem.detailTextLayout.font;
        [_headImageView hnk_setImageFromURL:[NSURL URLWithString:feed.head]];
        if (IS_MSColorString(feed.bg)) {
            _headImageView.backgroundColor = [UIColor colorWithHexString:feed.bg];
        } else {
            [_backgroudImageView hnk_setImageFromURL:[NSURL URLWithString:feed.bg]];
        }
        _functionView.timeLabel.text = @"腾讯大厦";
        [_functionView.pinglunButton setTitle:[@(_feed.n_likecount) stringValue] forState:UIControlStateNormal];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    _backgroudImageView.frame = _feed.layoutItem.backgroundLayoutItem.frame;
    CGRect headFrame = CGRectZero;
    headFrame.origin = _feed.layoutItem.topLayoutItem.frame.origin;
    headFrame.size.width = headFrame.size.height = CGRectGetHeight(_feed.layoutItem.topLayoutItem.frame);
    _headImageView.frame = headFrame;
    _nickNameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame), CGRectGetMinY(_headImageView.frame), _feed.layoutItem.contentWidth - CGRectGetMaxX(_headImageView.frame), 20);
    _detailFeedLabel.frame = _feed.layoutItem.detailTextLayout.frame;
    
    _functionsBackgroundView.frame = CGRectMake(0, CGRectGetHeight(_backgroudImageView.frame) - CGRectGetHeight(_feed.layoutItem.bottomLayoutItem.frame), CGRectGetWidth(_backgroudImageView.frame), CGRectGetHeight(_feed.layoutItem.bottomLayoutItem.frame));
    _detailTextBackgroudView.frame = CGRectMake(CGRectGetMinX(_backgroudImageView.frame),
                                                CGRectGetMinY(_detailFeedLabel.frame),
                                                CGRectGetWidth(_backgroudImageView.frame),
                                                CGRectGetMinY( [self convertRect:_functionsBackgroundView.frame fromView:_backgroudImageView])- CGRectGetMinY(_detailFeedLabel.frame));
    
    CGRect functionsRect = [self convertRect:_functionsBackgroundView.frame fromView:_backgroudImageView];
    _functionView.frame = functionsRect;
    
}
@end

//
//  QQSurroundLineTextField.m
//  QQMSFContact
//
//  Created by stonedong on 14/10/20.
//
//

#import "QQSurroundLineTextField.h"
#import <HexColor.h>

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif
@interface MSRightPrefixView : UIView
@property (nonatomic, strong) UILabel* label;
@end
@implementation MSRightPrefixView
- (void) layoutSubviews
{
    CGRect rect = self.bounds;
    rect.size.width -= 10;
    _label.frame = rect;
}
@end


@interface QQSurroundLineTextField ()
{
    UIView* _leftLineView;
    UIView* _rightLineView;
    UIView* _topLineView;
    UIView* _bottomLineView;
    
    BOOL _willCountChanged;
    
    NSDate* _firstEditDate;
    
    BOOL _onceMonitor;
    MSRightPrefixView* _rightPrefixView;
}
@end

@implementation QQSurroundLineTextField

- (void)  commonInit
{
    
    _firstEditingTime = 0;
    _onceMonitor = YES;
    
    _beginEditingTextCount = -1;
    UIView*(^CreateAView)(void) = ^(void) {
        UIView* aView = [UIView new];
        [self addSubview:aView];
        aView.backgroundColor = [UIColor colorWithHexString:@"#dedfe0"];
        return aView;
    };
    _leftLineView = CreateAView();
    _rightLineView= CreateAView();
    _bottomLineView= CreateAView();
    _topLineView= CreateAView();
    
    [self addTarget:self action:@selector(didBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(didFinishEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(didChangeEditing:) forControlEvents:UIControlEventEditingChanged];
    
    _willCountChanged = NO;
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _leftLabel = [UILabel new];
    _rightPrefixView = [MSRightPrefixView new];
    _rightPrefixView.label = _leftLabel;
    [_rightPrefixView addSubview:_leftLabel];
    self.leftView =  _rightPrefixView;
    self.leftViewMode = UITextFieldViewModeAlways;
    _leftLabel.textAlignment = NSTextAlignmentRight;
    
    _maxInputLength = 100;
}



- (void) didBeginEditing:(UITextField*)textFiled
{
    if (_onceMonitor) {
        _firstEditDate = [NSDate date];
    }
    _willCountChanged = YES;
}

- (void) didChangeEditing:(UITextField*)textFiled
{
    NSString* str = textFiled.text;
    if (str.length > _maxInputLength) {
        str = [str substringToIndex:_maxInputLength];
        [self setText:str];
    }
    
    if (_willCountChanged) {
        _beginEditingTextCount+=1;
        _willCountChanged = NO;
    }
}

- (void) didFinishEditing:(UITextField*)textfiled
{
    if (_onceMonitor) {
        _onceMonitor = NO;
    }
    _willCountChanged = NO;
}
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    [self commonInit];
    return self;
}

- (void) increaseBeginEditingTextCount
{
    int count = [self beginEditingTextCount];
    count++;
    [self setBeginEditingTextCount:count];
}

- (void) setSurroundModel:(int)surroundModel
{
    _topLineView.hidden= (surroundModel & QQSurroundLineTextFieldTop) == 0;
    _bottomLineView.hidden = (surroundModel & QQSurroundLineTextFieldBottom) == 0;
    _rightLineView.hidden = (surroundModel & QQSurroundLineTextFieldRight) == 0;
    _leftLineView.hidden = (surroundModel & QQSurroundLineTextFieldLeft) == 0;
    [self setNeedsLayout];
}
- (void) setRightEdgeInset:(UIEdgeInsets)rightEdgeInset
{
    _rightEdgeInset = rightEdgeInset;
    [self setNeedsLayout];
}

- (void) setTopEdgeInset:(UIEdgeInsets)topEdgeInset
{
    _topEdgeInset = topEdgeInset;
    [self setNeedsLayout];
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self bringSubviewToFront:_topLineView];
    [self bringSubviewToFront:_rightLineView];
    [self bringSubviewToFront:_leftLineView];
    [self bringSubviewToFront:_bottomLineView];
    _topLineView.frame = CGRectMake(_topEdgeInset.left,
                                _topEdgeInset.top,
                                CGRectGetWidth(self.bounds) - _topEdgeInset.left - _topEdgeInset.right,
                                1);
    _bottomLineView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.frame), 1);
    _leftLineView.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
    _rightLineView.frame = CGRectMake(CGRectGetWidth(self.frame) - _rightEdgeInset.right - 1, 0, 1, CGRectGetHeight(self.frame));
    
    _rightPrefixView.frame = CGRectMake(0, 0, _leftLabelPrefix, CGRectGetHeight(self.bounds));
    self.leftView = _rightPrefixView;
}
@end

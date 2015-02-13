//
//  QQSurroundLineTextField.h
//  QQMSFContact
//
//  Created by stonedong on 14/10/20.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    QQSurroundLineTextFieldTop = 1,
    QQSurroundLineTextFieldBottom = 1<< 1,
    QQSurroundLineTextFieldLeft = 1<< 2,
    QQSurroundLineTextFieldRight = 1 << 3
}QQSurroundLineTextFieldType;

@interface QQSurroundLineTextField : UITextField
@property (nonatomic, strong, readonly) UILabel* leftLabel;
@property (nonatomic, assign) CGFloat leftLabelPrefix;
@property (nonatomic, assign) int beginEditingTextCount;
@property (nonatomic, assign) int  surroundModel;
@property (nonatomic, assign) UIEdgeInsets topEdgeInset;
@property (nonatomic, assign) UIEdgeInsets rightEdgeInset;
@property (nonatomic, assign, readonly) NSTimeInterval firstEditingTime;
@property (nonatomic, assign) int maxInputLength;
@end
